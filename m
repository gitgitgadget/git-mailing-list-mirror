From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] define the way new representation types are encoded
 in the pack
Date: Sun, 30 Oct 2011 12:40:27 +0700
Message-ID: <CACsJy8Cz0R_s+VYRd+1wTTfbt_vH5dd3ALgZip0xn7rfYf6gpw@mail.gmail.com>
References: <7v62j9veh3.fsf@alter.siamese.dyndns.org> <7vwrbptzjm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 30 06:41:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKO8v-000691-21
	for gcvg-git-2@lo.gmane.org; Sun, 30 Oct 2011 06:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab1J3FlA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Oct 2011 01:41:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60685 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab1J3FlA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Oct 2011 01:41:00 -0400
Received: by faan17 with SMTP id n17so4676199faa.19
        for <git@vger.kernel.org>; Sat, 29 Oct 2011 22:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6Bbx5pxdsDFYZ7D6fw+HNLfwu89SOGpL3UkJSVMJyfA=;
        b=hawKhK/HC7+gxt8SQ4dll+uIHxWuO+4PLbssQQ3LDtXQzgMaCjbv7P064+hxpiPTGQ
         cfkQyero2jl6c4FAy63dvDnz6qUvzYFlmnNrmTQYup765zVjPT1N8niIdqLJ1R8fDKBp
         ucr2RAkMGyhZ4vvdnOTiV7pAupybJ1Ri3GkpY=
Received: by 10.223.14.140 with SMTP id g12mr18980984faa.34.1319953259077;
 Sat, 29 Oct 2011 22:40:59 -0700 (PDT)
Received: by 10.223.144.138 with HTTP; Sat, 29 Oct 2011 22:40:27 -0700 (PDT)
In-Reply-To: <7vwrbptzjm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184460>

On Fri, Oct 28, 2011 at 1:12 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> As people may be able to guess from the name, CAT_TREE is envisioned =
to
> encode a large data (primarily of type "blob") by recording the objec=
t
> name of a tree object and probably the total length, and would repres=
ent
> the concatenation of all blobs contained in the tree object when the =
tree
> is traversed in some fixed order (e.g. Avery's "bup split"). I am gue=
ssing
> that the payload for CAT_TREE representation type will be:
>
> =C2=A0- 20-byte object name for the top-level tree object;

Because all blobs in this tree object must be in a fixed order, and
they won't likely have meaningful names nor permission, should
CAT_TREE payload is a SHA-1 sequence of all blobs (or cat-trees if we
want nested trees) instead? IOW the tree is integrated into cat-tree
object, not as a separate tree object.

> =C2=A0- type of the basic object (commit, tree, blob, or tag) it repr=
esents,
> =C2=A0 even though it is unlikely that we would want to record such a=
 large
> =C2=A0 commit or tag that needs CAT_TREE representation;
>
> =C2=A0- the total length of the basic object it represents, even thou=
gh it is
> =C2=A0 redundant (you could traverse and sum the sizes of blobs conta=
ined in
> =C2=A0 the tree object), it would help sha1_object_info() and friends=
=2E This
> =C2=A0 will be the "some size" I mentioned in the previous message fo=
r this
> =C2=A0 representation type.

Not sure if it's related to representation types, but is there any way
(perhaps FLAT_BLOB type?) we can mark an object uncompressed, so we
can mmap() and access it directly?
--=20
Duy
