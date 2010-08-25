From: Justin Frankel <justin@cockos.com>
Subject: Re: [PATCH v2] git-merge: ignore space support
Date: Wed, 25 Aug 2010 08:51:25 -0700
Organization: Cockos Incorporated
Message-ID: <4C753BFD.5060807@cockos.com>
References: <20100823205915.GA4484@ns1.cockos.com>	<20100824022820.GE17406@burratino>	<5F681E95-9369-490A-84FE-55B99EA8FE63@cockos.com>	<20100825044006.GJ11619@burratino> <AANLkTimRyeMbLKLmbKJEqgGPDFo3OCsz=QwVzkSaP5n8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Junio C Hamano <gitster@pobox.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 17:52:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoIGk-00021F-Cm
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 17:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940Ab0HYPv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 11:51:59 -0400
Received: from ns1.cockos.com ([204.11.104.229]:51609 "EHLO ns1.blorp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444Ab0HYPv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 11:51:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by ns1.blorp.com (Postfix) with ESMTP id B4F971259C02;
	Wed, 25 Aug 2010 08:51:48 -0700 (PDT)
Received: from ns1.blorp.com ([127.0.0.1])
	by localhost (ns1.cockos.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NZZ4yM2ICNz7; Wed, 25 Aug 2010 08:51:26 -0700 (PDT)
Received: from [10.10.10.69] (poo.cockos.com [204.11.104.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ns1.blorp.com (Postfix) with ESMTPSA id 8221E1259C01;
	Wed, 25 Aug 2010 08:51:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <AANLkTimRyeMbLKLmbKJEqgGPDFo3OCsz=QwVzkSaP5n8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154447>

Bert Wesarg wrote:
> Hi,
>
> On Wed, Aug 25, 2010 at 06:40, Jonathan Nieder <jrnieder@gmail.com> wrote:
>   
>> Justin Frankel wrote:
>>
>>     
>>> Fine by me... (ok if I were to nitpick I would probably make most of
>>> the internal static functions check that opts was non-NULL before
>>> dereferencing, in case the calling code ever changed
>>>       
>> Not a bad idea.  I'll squash in something like this.
>>
>> A real BUG_ON macro would make this less ugly.
>>     
>
> I think exactly because of this there is no prior art of using NULL as
> 'use the default options'. Without this all these NULL pointer checks
> wont be necessary.
>   

The only danger is that ll_merge()'s signature didn't change in such a 
way to break compilation, i.e:

int ll_merge(mmbuffer_t *result_buf,
             const char *path,
             mmfile_t *ancestor, const char *ancestor_label,
             mmfile_t *ours, const char *our_label,
             mmfile_t *theirs, const char *their_label,
             int flag);

becomes:

int ll_merge(mmbuffer_t *result_buf,
             const char *path,
             mmfile_t *ancestor, const char *ancestor_label,
             mmfile_t *ours, const char *our_label,
             mmfile_t *theirs, const char *their_label,
             struct whatever *conf);

In this case, passing 0 as the last parameter will compile either way.

Sure, we can grep all of the source, but who knows when something else 
will get merged in...

-Justin
