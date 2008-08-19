From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 1/3 v10] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Tue, 19 Aug 2008 16:37:45 +0200
Message-ID: <48AADAB9.4070706@gmail.com>
References: <48A9CEC0.2020100@gmail.com> <1219088389-14828-1-git-send-email-LeWiemann@gmail.com> <7vd4k5kdl3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 16:39:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVSMX-0003eO-LM
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 16:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbYHSOhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 10:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbYHSOhr
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 10:37:47 -0400
Received: from gv-out-0910.google.com ([216.239.58.185]:6835 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbYHSOhq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 10:37:46 -0400
Received: by gv-out-0910.google.com with SMTP id e6so680924gvc.37
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=hfcYGms2E7vgkue3rmys4pMP+6hrNaUtDGBm/TtWHmo=;
        b=nezTwAS/xN1T4z1PrmSsi9WrRYas4X8lhYULqo4V5RiJAmAW85WzEc+2aMEcZN0+6J
         52J/eGAUEtpEHjG1PubEhLJii5hv8mAIh2OWR27KBVtEf7m4tVvmudnvQ6NBGROtfsy9
         wJ15Reevv648tdInNW/jtT0HvjbuPf+v+D6qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=dhyQ1R4wY9DYQvd3A934LDom0u/SuPJ+I+1pWKKtkfESiPcCwptZkzkWwCKrmlMNMo
         0C0ujb4iGC1k07d4H8xITe9+f5BYhWEPeUPBA9R48cgdHg3Yabmp2oDXugE2KBjFUyxC
         7JaQYAGdKQ1fexlOk9EEl3vcahtWNKz7fU61c=
Received: by 10.103.169.1 with SMTP id w1mr4888263muo.107.1219156664812;
        Tue, 19 Aug 2008 07:37:44 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.210.90])
        by mx.google.com with ESMTPS id e8sm1047117muf.6.2008.08.19.07.37.42
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Aug 2008 07:37:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080707 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
In-Reply-To: <7vd4k5kdl3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92866>

Junio C Hamano wrote:
> Lea Wiemann <lewiemann@gmail.com> writes:
> 
>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
> 
> This s-o-b chain is a bit confusing; was this authored by you or Jakub?

Jakub started it, I extended it.  Should we have different SOB lines?

>> +safe_chmod () {
>> +	chmod "$1" "$2" &&
>> +	if [ "$(git config --get core.filemode)" = false ]
>> +	then
>> +		git update-index --chmod="$1" "$2"
>> +	fi
>> +}
> 
> You have this in t9500 as well.  Perhaps it can go to test-lib?

Will do in the next version of this patch.

>> +# check if test can be run
>> +"$PERL_PATH" -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
>> +	test_expect_success \
>> +		'skipping gitweb tests, perl version is too old' :
> 
> It may be helpful to say what exactly is lacking

Right.  Since Encode doesn't run on older Perl versions anyway, I'm
changing it to

"$PERL_PATH" -e 'use 5.008' >/dev/null 2>&1 || {
	test_expect_success \
		'skipping gitweb tests, Perl 5.8 or newer required' :

> t3300, t4000, t5540, t9113,
> t9113, t9600, and t9700 use "say" (or say_color), t3902, t4016, t5000, and
> t7004 just use "echo", and t9200, t9400, t9401 and t9500 do this phoney
> "success".  We should standardize these by introducing "test_stop_early
> $msg".

Yup; maybe "test_skip_all" is clearer though.  I think this should be
done in a separate patch.

>> +	test_tick && git pull . b
> 
> That "pull . b" is somewhat old fashioned, but is Ok.

Is "git merge b" equivalent?  (The test still passes with it.)

>> +large_cache_root="../t9503/large_cache.tmp"
> 
> Please use $TEST_DIRECTORY without relying on the location of "t/trash
> directory"; it was painful to fix all of them.

Ok, fixed all of those.  I'll also move the cache-setup code to patch 3
(gitweb caching), since it doesn't belong here as long as caching isn't
implemented.

>> +# Grep
> 
> With these search oriented tests, making sure that you would find what you
> expect to find is obviously important, but shouldn't you be also making
> sure that irrelevant entries are not found?

Technically yes, but I'm not inclined at the moment to write that test
(at least while I'm not hacking the search part of gitweb).  The test is
basically only there to exercise the code and make sure it returns
*something* sensible, which is where most breakages would occur.

Thanks for all your feedback!  I'll wait with sending a new patch series
until I've collected all feedback.

-- Lea
