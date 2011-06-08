From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Git-mediawiki : Encoding problems in perl
Date: Wed, 8 Jun 2011 15:45:43 +0200
Message-ID: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: thomas@xteddy.org
X-From: git-owner@vger.kernel.org Wed Jun 08 15:46:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUJ5K-0006ul-Gv
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 15:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab1FHNqF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 09:46:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54372 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755024Ab1FHNqD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 09:46:03 -0400
Received: by pvg12 with SMTP id 12so248089pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=F8ekPdV1A3YUQk8QSHrSezY8IRdrIeIoLMJgWXu8OQQ=;
        b=N8ft0BbPXZ79sPnYt18eNgRIwuLgQYHPyZel0ih5W/8azJIDZA1I4OTwKBcbhYQM41
         bdgKF2hnHpdpOKZ/s/5YoiYdlBd8FsunHZuxoMcdsadjBDZDBTsQ4OSbBSlFzftNhDSu
         6F9FiAr+F3i9FLXDF91t+Lr7wVy9BlnxJfygE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=I+Mbwc4LA+3GPJZiPGaRXLdnfG5/ZJHyiXVKG81zMjmKnYri49TTrCEEv9ZIkJiMrc
         mepy0XBSOdDQNmuNHrBUsSDkqGf66UInzVoAYsx6R6dX8DpGblhaZDB1jQZUrPNSPkYj
         NNfo5y3JCLZlvFLaI7vjS//QxRctn4Z+EDA4c=
Received: by 10.142.50.7 with SMTP id x7mr243557wfx.414.1307540763412; Wed, 08
 Jun 2011 06:46:03 -0700 (PDT)
Received: by 10.142.136.2 with HTTP; Wed, 8 Jun 2011 06:45:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175371>

Hi,
While working on the git-mediawiki project[1], we ran into some
problems regarding utf8 encoding of files. Most of them have been
solved, however, one is still pretty annoying.
Let me illustrate it :

I want to edit a page on mediawiki using the API, with a very simple ex=
ample :

my $mw =3D MediaWiki::API->new();
$mw->edit( {
        action =3D> 'edit',
        title =3D> 'Main_page',
        text =3D> '=E9t=E9',
} ) ;

But, when I look at the page on mediawiki, I see weird characters : =C3=
=A9t=C3=A9.

I tried text =3D> encode_utf8('=E9t=E9') with no success.

This makes pushing changes from git to mediawiki buggy since pulling a
file with accentuated characters and pushing it right after changes
things on the wiki.

While googling (a lot), I found that utf8 was pretty tricky in perl...
The only thing that seems to solve things is a simple addition of 'use
encoding utf8' at the top of our script.
However
A) Adding this line requires that I remove 'use strict;'
B) I found some information about this pragma encoding and it seems to
be unadvised to use it

Do you have any information regarding this issue ?

Thanks,
--=20
J=E9r=E9mie Nikaes
[1] https://github.com/Bibzball/Git-Mediawiki
