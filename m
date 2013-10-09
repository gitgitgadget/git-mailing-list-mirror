From: Johan Herland <johan@herland.net>
Subject: Re: [RFC/PATCHv2 2/3] git-svn: Warn about changing default for
 --prefix in Git v2.0
Date: Wed, 9 Oct 2013 14:18:11 +0200
Message-ID: <CALKQrgd3wPEwK2vHkFPgt2hXASwB0ypAjzvnR8fV-WAgjggdqg@mail.gmail.com>
References: <20131003190139.GA8710@dcvr.yhbt.net>
	<1381015833-696-1-git-send-email-johan@herland.net>
	<1381015833-696-2-git-send-email-johan@herland.net>
	<CAPig+cRAg4NpAsUWGQPsLcaFmDn61POv1pdHKCrSyQbM0KgM4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 14:18:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTsic-0003rY-6l
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 14:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752292Ab3JIMSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 08:18:18 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:37192 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab3JIMSR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 08:18:17 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VTsiV-0000jF-DT
	for git@vger.kernel.org; Wed, 09 Oct 2013 14:18:15 +0200
Received: from mail-pd0-f175.google.com ([209.85.192.175])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VTsiV-0001Lf-4f
	for git@vger.kernel.org; Wed, 09 Oct 2013 14:18:15 +0200
Received: by mail-pd0-f175.google.com with SMTP id q10so825101pdj.20
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 05:18:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oCf/c0DO0WumBxhTVJ9XZNfnzeAYLb2XdtjIeIxQJkk=;
        b=T3xBkHH17x8MVtibsabGdw2XEf3bGXrN8Vvm3OfzGsunv87jHk9yut52CQSB8EgivH
         kWMZg+BBSPR77gU2ngnhjM72YP3I/4Vz+a2wAbGD4lCezvoo7TTdVH7aBIlH32RAU7vt
         dezu2pqLlrqXWByJN2dHu5gcyOO8DW5Kz43B2xSzszKyy4bp8YYC6YRhM3tBEJf5a0Sf
         9QVO4VN/21C+wnCkpiThD30wrYS0iRs5efYuVcan+sDNOlL0E/NZgRGZMVDELleDh2M5
         qEt+FMq5Smt9+y3PcWTjpeRJhKaDqh7sMSW3D6rD6rZm8WnyyR8gmWpdom29K/DMwJf/
         NeUQ==
X-Received: by 10.66.159.132 with SMTP id xc4mr9220352pab.27.1381321091209;
 Wed, 09 Oct 2013 05:18:11 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Wed, 9 Oct 2013 05:18:11 -0700 (PDT)
In-Reply-To: <CAPig+cRAg4NpAsUWGQPsLcaFmDn61POv1pdHKCrSyQbM0KgM4A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235810>

On Wed, Oct 9, 2013 at 3:34 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Oct 5, 2013 at 7:30 PM, Johan Herland <johan@herland.net> wrote:
>> diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
>> index b7ef9e2..1c8d049 100755
>> --- a/t/t9117-git-svn-init-clone.sh
>> +++ b/t/t9117-git-svn-init-clone.sh
>> @@ -52,4 +52,71 @@ test_expect_success 'clone to target directory with --stdlayout' '
>>         rm -rf target
>>         '
>>
>> +test_expect_success 'clone without -s/-T/-b/-t does not warn' '
>> +       test ! -d trunk &&
>> +       git svn clone "$svnrepo"/project/trunk 2>warning &&
>> +       test_must_fail grep -q prefix warning &&
>> +       rm -rf trunk &&
>> +       rm -f warning
>> +       '
>> +
>> +test_svn_configured_prefix () {
>> +       prefix=$1
>
> Did you want to maintain the &&-chain here?
>
>> +       cat >expect <<EOF
>
> And here?

Yes, will add && in both places. Thanks.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
