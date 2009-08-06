From: Tim Harper <timcharper@gmail.com>
Subject: Re: surprising error message in parse_opt_with_commit
Date: Thu, 6 Aug 2009 13:41:53 -0600
Message-ID: <e1a5e9a00908061241g43108278tb37f2982056ada81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 06 21:42:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ8r0-0006HT-Px
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 21:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575AbZHFTmO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2009 15:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756562AbZHFTmN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 15:42:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:18174 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756578AbZHFTmN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Aug 2009 15:42:13 -0400
Received: by rv-out-0506.google.com with SMTP id f6so235258rvb.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 12:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=z84oaaKrkyUrCr8MsQFuAVhCQUMioVvXXaEUSr1u0/8=;
        b=ATJeDCao/mQFy8OtiOYpa0QItUmkh+IpfFDBWt/NNtjnp7PL+gFSm4sH4pqvUmAq4d
         JqFCz+8jgKVWDtui7iKDti7r0zJIJLCHTn76s65JMqN6Nfhh2T8xGRWjhkCYLJgRzvNE
         fbaopdAWo2UEoQZnNl64Ibru/9gEnMJ4SA9hI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=aZJdUFAxEqHYc+90b7tD4k9rAV4lTpBoF3C5W1a9KKFuuzFTWRaM7UO6buNlXtKxKh
         7lP46YTwjnQVMZqEe/8+KpioWM9YjuC2ETauJi0D5kXBnWVDN4oUBkJ9L8tZmpmUfxAk
         r54lw1LXpS/XtdBeFhUX5kFsAYLtil8D0ikaA=
Received: by 10.140.208.15 with SMTP id f15mr136266rvg.49.1249587733079; Thu, 
	06 Aug 2009 12:42:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125114>

On Thu, Aug 6, 2009 at 1:34 PM, Shawn O. Pearce<spearce@spearce.org> wr=
ote:
> Tim Harper <timcharper@gmail.com> wrote:
>> =C2=A0610 int parse_opt_with_commit(const struct option *opt, const =
char
>> *arg, int unset)
>> =C2=A0611 {
>> =C2=A0612 =C2=A0unsigned char sha1[20];
>> =C2=A0613 =C2=A0struct commit *commit;
>> =C2=A0614
>> =C2=A0615 =C2=A0if (!arg)
>> =C2=A0616 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;
>> =C2=A0617 =C2=A0if (get_sha1(arg, sha1))
>> =C2=A0618 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error("malformed =
object name %s", arg);
>> =C2=A0619 =C2=A0commit =3D lookup_commit_reference(sha1);
>> =C2=A0620 =C2=A0if (!commit)
>> =C2=A0621 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return error("no such co=
mmit %s", arg);
>> =C2=A0622 =C2=A0commit_list_insert(commit, opt->value);
>> =C2=A0623 =C2=A0return 0;
>> =C2=A0624 }
>>
>> It appears the get_sha1 call is returning true, causing the 'malform=
ed
>> object name' error to be returned. =C2=A0However, it seems that idea=
lly
>> since efabdfb is not malformed (it would be a valid ref if it
>> existed), the execution path should continue to line 619, receive no
>> commit, and fail on 621.
>
> get_sha1 is responsible for expanding an abbreviated ID to the
> full ID. =C2=A0If it can't do the expansion, it errors out. =C2=A0The=
 code
> is correct as-is, though the error message on 618 is a bit odd.
>
> --
> Shawn.
>

ok, that makes more sense.  I notice if I pass a full, mutated
40-character sha1 commit, I get the error message I expect.
