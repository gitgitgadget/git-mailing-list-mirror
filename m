From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/7] gitweb: introduce remote_heads feature
Date: Fri, 17 Sep 2010 17:39:58 +0200
Message-ID: <AANLkTin43YXnfETqK2ZJASaT5gMemrJqiX+xzfn13s7n@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1284629465-14798-2-git-send-email-giuseppe.bilotta@gmail.com> <201009162341.20380.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 17:40:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owd34-0002OC-0e
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 17:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020Ab0IQPkU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Sep 2010 11:40:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34910 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab0IQPkT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Sep 2010 11:40:19 -0400
Received: by iwn5 with SMTP id 5so2083285iwn.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 08:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=r6vkdwXlzjZu8GU3CMwSe/Ikg9/QvHhbBnBlmR4+kBM=;
        b=tHGk5x5YLWNMQb7DMdnPoig25ywnzKxo0EYcBmeW6VsihLjURZTlkYL9NayHfYYyPw
         3ttzRv88pZW9bTyzSgnGlBDP6Tt1YyTDsEhY47SBKfBUr71+JCfmOxNTw6nslz93oQYt
         TTDbZipXSvCWgysiRjObhZWHJ37BhTvFu9tPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ISe2BOGDFWgm3Vo9w4MQcoFRExxOYDS5mJZRxQ0ij5T7ivF+IBwYBb0uTXkO48uk6w
         ArGtyGP4+RbBUyLm6ed0lG2fAXb4HahBe7mA7zx8Bs9hs39450vRhg6BKuDEYS2gZKT4
         JzsPlf5RDLY8jG5JC2PgSzOXKv1d1x9UGggu4=
Received: by 10.231.59.83 with SMTP id k19mr4883039ibh.178.1284738018385; Fri,
 17 Sep 2010 08:40:18 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Fri, 17 Sep 2010 08:39:58 -0700 (PDT)
In-Reply-To: <201009162341.20380.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156389>

2010/9/16 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 or return;
>> =A0 =A0 =A0 while (my $line =3D <$fd>) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 my %ref_item;
>> @@ -3160,8 +3174,9 @@ sub git_get_heads_list {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 my ($committer, $epoch, $tz) =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ($committerinfo =3D~ /^(=
=2E*) ([0-9]+) (.*)$/);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 $ref_item{'fullname'} =A0=3D $name;
>> - =A0 =A0 =A0 =A0 =A0 =A0 $name =3D~ s!^refs/heads/!!;
>> + =A0 =A0 =A0 =A0 =A0 =A0 $name =3D~ s!^refs/(head|remote)s/!!;
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 $ref_item{'class'} =3D $1;
>
> Is it used anywhere, or is it left to be used by a further commit in
> the series? =A0If it is the latter, perhaps it would be worth mention=
ing
> in the commit message?

Actually, I think this might be a leftover from some previous
iteration (IIRC my first version of this patchset listed all heads
under 'heads' grouping them by the class defined here, whereas now we
have the two separate sections). I should probably scratch it (even
though a similar mechanism is already in place in format_ref_marker
and it might be useful to coalesce this when parsing refs)

--=20
Giuseppe "Oblomov" Bilotta
