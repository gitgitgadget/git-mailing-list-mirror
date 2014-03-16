From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Trust issues with hooks and config files
Date: Sun, 16 Mar 2014 19:15:45 +0530
Message-ID: <5325AB09.4080705@gmail.com>
References: <5318ECFF.40908@0x4a42.net> <20140307210403.GA6790@sigill.intra.peff.net> <531CA468.3060604@0x4a42.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SOqsxBF6rBPr976l9nnqqVFlJDHCSFcWM"
Cc: git@vger.kernel.org
To: Julian Brost <julian@0x4a42.net>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 16 14:46:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPBO5-0000MK-Dz
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 14:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbaCPNp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 09:45:57 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:44120 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbaCPNp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 09:45:56 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so4511841pdi.33
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=bKvC4vUoRBOAhid0AuyrvZQmgpM3+Ku122nQm1IUQTw=;
        b=z+6HJn3HquHzml/XtPijr5ZvWqEPiAWbmYqKFoVCEE6I+G5pKVIxCJg05ZkmSWCOmf
         MkVAGnsJAFSKxcja8R4CEImZynTR7P7Jgk7ie2jgqEt7j5vLMktOwlUZjAhwoQXCo7+0
         Jtu8NGqZ0W6VG9fUM9fEeJa4XL0UKYTLhIyO5iCu7/u3pLRrYg0WHFsaj+2WG7weKV7B
         SohMsjDrOkg7Uy2JYA3rtAqaHfmSOMgGSPhZlK04QN7RZjeK5rAIcKk+XclbYWwGi0Sb
         0aJQu3usOdev9IwXEk2ALwE8Roa4MrrcqVmmf9e0KepFFhttoIY7Pgty9lAoW67WwgjK
         Ie/w==
X-Received: by 10.66.16.131 with SMTP id g3mr2395163pad.138.1394977555731;
        Sun, 16 Mar 2014 06:45:55 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.167.5])
        by mx.google.com with ESMTPSA id ha11sm34512569pbd.17.2014.03.16.06.45.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Mar 2014 06:45:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <531CA468.3060604@0x4a42.net>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244200>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SOqsxBF6rBPr976l9nnqqVFlJDHCSFcWM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 03/09/2014 10:57 PM, Julian Brost wrote:
> On 07.03.2014 22:04, Jeff King wrote:
>> Yes, this is a well-known issue. The only safe operation on a
>> repository for which somebody else controls hooks and config is to
>> fetch from it (upload-pack on the remote repository does not
>> respect any dangerous config or hooks).
>
> I'm a little bit surprised that you and some other people I asked see
> this as such a low-priority problem as this makes social engineering
> attacks on multi-user systems, like they are common at universities,
> really easy (this is also how I noticed the problem).

This, and a lot more control related issues, are solved by tools like
gitolite (which I maintain) and Gerrit (from Google), and also many GUI
based access control tools like gitlab, gitorious, etc.

In these schemes the user does not have a "unix" account on the server,
and any hooks that run will run as the "hosting user".  Access is either
via ssh pub keys (most commonly) or http auth.

It is my belief that most multi-user systems have installed one of these
systems, and therefore the situation you speak of does not arise.  They
probably didn't install them to solve *this* problem, but to keep some
semblance of control over who can access what repo, but as a side-effect
they solve this problem also.

sitaram

>> It has been discussed, but nobody has produced patches. I think
>> that nobody is really interested in doing so because:
>
>> 1. It introduces complications into previously-working setups
>> (e.g., a daemon running as "nobody" serving repos owned by a "git"
>> user needs to mark "git" as trusted).
>
>> 2. In most cases, cross-server boundaries provide sufficient
>> insulation (e.g., I might not push to an evil person's repo, but
>> rather to a shared repo whose hooks and config are controlled by
>> root on the remote server).
>
>> If you want to work on it, I think it's an interesting area. But
>> any development would need to think about the transition plan for
>> existing sites that will be broken.
>
> I can understand the problem with backward compatibility but in my
> opinion the default behavior should definitely be to ignore untrusted
> config files and hooks as it would otherwise only protect users that
> are already aware of the issue anyways and manually enable this option.=

>
> Are there any plans for some major release in the future that would
> allow introducing backward incompatible changes?
>
> I would definitely spend some time working on a patch but so far I
> have no idea of git's internals and never looked at the source before.
>
>> At the very least, the current trust model could stand to be
>> documented much better (I do not think the rule of "fetching is
>> safe, everything else is not" is mentioned anywhere explicitly).
>
> Good point but not enough in my opinion as I haven't read every git
> manpage before running it for the first time.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



--SOqsxBF6rBPr976l9nnqqVFlJDHCSFcWM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTJasOAAoJEKRCkIUIgjelBc0P/RpFafMdAVAbYAp6swsnCSS5
2ARuVGuhL3nTkjqhdevrVUbsscLDDBY3P+IYMMTvSbzcaC/0Iw9dpnc+Cl3hM9IA
uGSfda7Ot+8SrFvVu2vjEi3Zf9QPyq5PSYN8RQCOv0rY6txCSMgkAJH5dcRkBrni
PGo8KjRMeWScUuILG32XJQfz/8AOoI2TNQOckTDm29h+w3sMVD15aczv9n9GJdmg
ivLFs3DdbnSJbssT3tlitu/H3uDDaPkydwwu25MTR8fYEuiKKynMOYQSGq3WWNYk
gUkA93GdAheLkU3c4B7CLk03+gCRhMg0Im8SCwt8vha6YI7kp/e7gDr1hC5V/Uh1
PcDAyMmssgUfkngqK6hPEcz4TcX+onssMpQEKdkFN0e9qJsqK6zJ4r3fs1ELmYMy
I0GL0S8QdhBWfIgFvRULN+S7LTLf3F4Puw1xu4oW89dkSw3ssB7V5nN4YuKRKdSO
yPPKC/mcBNH6/VRERXxVlC9M06ZC5b5mNuJakObGBzlsKYWo+pgGyvMbOYYSSZYi
y7pRZyPcjmjIsDwV9JfVcItX3drxoS3eGdWo5AzdfZSJ3l7LTHCds+0qnHP0XXjP
S8mg1YKtqX2O8DgR+Rw4OBw9zmASEqryA16y79SHyg35Lo/xRixA1+SMsTBxEuPR
F+HGut5s956tnDPSGv+d
=I5lk
-----END PGP SIGNATURE-----

--SOqsxBF6rBPr976l9nnqqVFlJDHCSFcWM--
