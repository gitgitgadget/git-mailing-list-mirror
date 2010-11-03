From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCHv2 2/2] submodule: only preserve flags across recursive status/update invocations
Date: Tue, 2 Nov 2010 22:45:32 -0700
Message-ID: <E0BA6B5C-AB98-4D72-8E8A-B4EA4B7A17CC@sb.org>
References: <5BE96A08-B8AB-4041-ABF2-7095EB5DD585@sb.org> <1288760740-10075-2-git-send-email-kevin@sb.org> <20101103053827.GD10631@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 06:45:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDWAY-00051C-Qv
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 06:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab0KCFpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 01:45:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53446 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0KCFpf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 01:45:35 -0400
Received: by pwj3 with SMTP id 3so96680pwj.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 22:45:34 -0700 (PDT)
Received: by 10.142.88.18 with SMTP id l18mr1816918wfb.338.1288763134856;
        Tue, 02 Nov 2010 22:45:34 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w22sm12634045wfd.19.2010.11.02.22.45.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 22:45:34 -0700 (PDT)
In-Reply-To: <20101103053827.GD10631@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160584>


On Nov 2, 2010, at 10:38 PM, Jonathan Nieder wrote:

> Kevin Ballard wrote:
> 
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -374,41 +374,35 @@ cmd_init()
> [...]
>> 		--reference)
>> 			case "$2" in '') usage ;; esac
>> 			reference="--reference=$2"
>> -			shift 2
>> +			orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
>> +			shift
> 
> Hmm.  Maybe a helper would make it clearer.
> 
> 	save_arg () {
> 		orig_flags="$orig_flags $(git rev-parse --sq-quote "$1")"
> 	}
> 
> making this
> 
> +			save_arg --reference
> +			shift

I considered that, but I already dislike the fact that orig_flags is a global.
I left it as such for the sake of not fixing what ain't broke, but the use of
a helper function would imply that the global nature of the variable is
intentional.

>> --- a/t/t7407-submodule-foreach.sh
>> +++ b/t/t7407-submodule-foreach.sh
>> @@ -238,4 +238,23 @@ test_expect_success 'use "git clone --recursive" to checkout all submodules' '
>> 	test -d clone4/nested1/nested2/nested3/submodule/.git
>> '
>> 
>> +test_expect_success 'use "update --recursive nested1" to checkout all submodules rooted in nested1' '
> 
> Maybe a submodule status --cached --recursive -- <files> test, too?

Good idea.

-Kevin Ballard