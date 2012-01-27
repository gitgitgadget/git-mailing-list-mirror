From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Fri, 27 Jan 2012 10:47:29 +0700
Message-ID: <CACsJy8ASXrmBvxj4DxjGiqYhPkr1Yp02CAyMqKrfyfrzaAw-2g@mail.gmail.com>
References: <20120126073547.GA28689@sigill.intra.peff.net> <20120126074208.GD30474@sigill.intra.peff.net>
 <4F211C0C.7060400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 27 04:48:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqcnI-0002Lu-1L
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 04:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150Ab2A0DsD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jan 2012 22:48:03 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36372 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab2A0DsB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jan 2012 22:48:01 -0500
Received: by bkas6 with SMTP id s6so1035409bka.19
        for <git@vger.kernel.org>; Thu, 26 Jan 2012 19:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=rbV7Y6LF17L/Usmlya6WEVioib0TgsmivOsm0uRqFLU=;
        b=icVUFiKSSFuf+7p/f/I56XcBZ3S3w+sQFMkhTyRRLvtNTkmNlxPrYxKgCe5/OMhPF+
         k0avQqVlhteNn1EC4Xs7cuwCtL5wd+NFD2g+H6ZAc4f+KU0p3qSRFjFN/dZTDvV2CcdO
         C7toTWDTliqoVaqdLIUlcObsevFFYj5qbCWJ0=
Received: by 10.204.10.65 with SMTP id o1mr2244069bko.19.1327636079351; Thu,
 26 Jan 2012 19:47:59 -0800 (PST)
Received: by 10.204.33.70 with HTTP; Thu, 26 Jan 2012 19:47:29 -0800 (PST)
In-Reply-To: <4F211C0C.7060400@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189185>

On Thu, Jan 26, 2012 at 4:25 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 1/26/2012 8:42, schrieb Jeff King:
>> +static int handle_ref_include(const char *ref, void *data)
>> +{
>> + =C2=A0 =C2=A0 unsigned char sha1[20];
>> + =C2=A0 =C2=A0 char *buf;
>> + =C2=A0 =C2=A0 unsigned long size;
>> + =C2=A0 =C2=A0 enum object_type type;
>> + =C2=A0 =C2=A0 int ret;
>> +
>> + =C2=A0 =C2=A0 if (get_sha1(ref, sha1))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> + =C2=A0 =C2=A0 buf =3D read_sha1_file(sha1, &type, &size);
>> + =C2=A0 =C2=A0 if (!buf)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error("unable to =
read include ref '%s'", ref);
>> + =C2=A0 =C2=A0 if (type !=3D OBJ_BLOB)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return error("include re=
f '%s' is not a blob", ref);
>> +
>> + =C2=A0 =C2=A0 ret =3D git_config_from_buffer(git_config_include, d=
ata, ref, buf, size);
>> + =C2=A0 =C2=A0 free(buf);
>> + =C2=A0 =C2=A0 return ret;
>> +}
>
> What happens if a ref cannot be resolved, for example due to reposito=
ry
> corruption? Does git just emit an error and then carries on, or does =
it
> always die? Can I run at least git-fsck in such a case?

Moreover, if I specify sha-1 in the config (it's discouraged but not
forbidden from the code), can git-prune remove the blob?
--=20
Duy
