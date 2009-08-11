From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v2 4/4] read-tree: add --no-sparse to turn off sparse 
	hook
Date: Tue, 11 Aug 2009 08:38:03 +0700
Message-ID: <fcaeb9bf0908101838k37751fclac5c572eb042138e@mail.gmail.com>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com> 
	<1249917562-5931-2-git-send-email-pclouds@gmail.com> <1249917562-5931-3-git-send-email-pclouds@gmail.com> 
	<1249917562-5931-4-git-send-email-pclouds@gmail.com> <1249917562-5931-5-git-send-email-pclouds@gmail.com> 
	<alpine.DEB.1.00.0908101842530.8324@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 11 03:38:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MagJr-0002Pp-6h
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 03:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbZHKBiX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 21:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbZHKBiX
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 21:38:23 -0400
Received: from mail-yw0-f193.google.com ([209.85.211.193]:60556 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbZHKBiW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 21:38:22 -0400
Received: by ywh31 with SMTP id 31so4445893ywh.4
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 18:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=V9+YTvIKpccBaYX/Kzw/u1v9VkfSmqx8+XRpVH1sDsI=;
        b=A1QzOxQGF28MYCIGc77LET34cJom5mI09VdS8oecSj2v6pde2ofp0Ay5mmd1CAC4mH
         3S9F58fLTBUglgsorNP6XNa4Yp3LRRNABsUNinqe6LnVA+8AZVS9zBZe2RqqnG3Ug6K4
         tjHLYv/+mslsLI39VgKINXcZo4OGrrJoIEiPk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=u0l4PD9UtwLPk+bm/Aqd3zFz3256d+cQRDUtmXGgmxKvNgOua9PqvxBw2oY/GlYvtX
         qMMCdiQEOfWI0hOUrbh6godB1ABcUWYO2Kf25Wsue+SK8PnpCXbVRBpLtfnLr8bpw2T1
         9nrDKETSfbDXw1ktSQIhirlJfkXpQJzMmjd6M=
Received: by 10.100.94.4 with SMTP id r4mr4494182anb.171.1249954703133; Mon, 
	10 Aug 2009 18:38:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908101842530.8324@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125509>

2009/8/10 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 10 Aug 2009, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index f407bf5..d087112 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -530,8 +530,10 @@ int unpack_trees(unsigned len, struct tree_desc=
 *t, struct unpack_trees_options
>> =C2=A0 =C2=A0 =C2=A0 if (o->trivial_merges_only && o->nontrivial_mer=
ge)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return unpack_faile=
d(o, "Merge requires file-level merging");
>>
>> - =C2=A0 =C2=A0 if (run_sparse_hook(o))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return unpack_failed(o, =
NULL);
>> + =C2=A0 =C2=A0 if (!o->no_sparse_hook) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (run_sparse_hook(o))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 return unpack_failed(o, NULL);
>> + =C2=A0 =C2=A0 }
>>
>
> IMHO this would read nicelier as
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!o->no_sparse_hook && run_sparse_hook(=
o))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return unpack_=
failed(o, NULL);

Right.

>> diff --git a/unpack-trees.h b/unpack-trees.h
>> index ad21823..81eb2ef 100644
>> --- a/unpack-trees.h
>> +++ b/unpack-trees.h
>> @@ -30,6 +30,7 @@ struct unpack_trees_options {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
skip_unmerged,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
initial_checkout,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
diff_index_cached,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0no_s=
parse_hook,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
gently;
>
> Hmm. =C2=A0I understand that the assumption is that memset(&opts, 0,
> sizeof(opts)); should give you a sensible default, but I cannot avoid
> noticing that "no_sparse_hook =3D 0" is a double negation, something =
to be
> avoided...

skip_sparse_hook then? :-)
--=20
Duy
