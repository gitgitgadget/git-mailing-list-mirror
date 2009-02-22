From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Sun, 22 Feb 2009 19:18:12 +0200
Message-ID: <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
	 <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 18:20:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbHzT-0005jv-RK
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 18:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbZBVRSP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 12:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbZBVRSP
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 12:18:15 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:42392 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbZBVRSO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 12:18:14 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2540079fgg.17
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 09:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hz4ZAjZSw0xyLZ19vV/G9xafKEHDo4UnZaaEovg6l4E=;
        b=dzHqNWn1cGTXuMrBsoCpV57aECgxZDPZsYRT1HHR7bIh0BGxXKfN3rsQgmvf3+HXew
         eMofyak8GmXtx8EI4Lokusu8APCum6E9OVoh6a0uRfQC4YKOMLZkB8L6rTxfRHISD8XK
         0mzDD18nYvujkYVvYekuPZQja34GKPejwOwfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Wjhuv+YeS6iDnCjcf0XKoJkOVLWZRzRmRftnIKwp7zSi3T2OM28Xc7SVLXDSmWc0+z
         E8iFueuBB8BiNhWEDhzCjrhOdz3bgrBkzrec6DiGKOAjuRbdydiZ4MROTlZTzvT6fM8q
         BOW9+GxE3XOZqKZ6VTomOIfyT+rEVMUSAgZSI=
Received: by 10.86.65.9 with SMTP id n9mr2372233fga.55.1235323092896; Sun, 22 
	Feb 2009 09:18:12 -0800 (PST)
In-Reply-To: <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111024>

On Sun, Feb 22, 2009 at 6:49 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> --format=3D:foo is a shorthand for --pretty=3Dtformat:foo, otherwise=
 this
>> new option acts just like --pretty=3Dfoo, except it's more intuitive=
 for
>> users of 'git log'.
>
> It's been quite a long time since the earlier discussion, but I wonde=
r why
> you need the colon before "foo" for this new shorthand. =C2=A0I *thin=
k* you are
> also introducing "--format=3Dshort" as a synonym to "--pretty=3Dshort=
", but
> I do not think it is necessary.

Well, my hope was to replace --pretty=3Dshort with --format=3Dshort, bu=
t
you said that would break other scripts.

>> As discussed in the mailing list, this is implemented as an undocume=
nted
>> option.
>
> Maybe somebody wants to document it.

Ah, I would gladly add the documentation, shall I write that it's an
'alternative' option similar to --pretty?

> Needs trivial tests.

All right.

>> + =C2=A0 =C2=A0 } else if (!prefixcmp(arg, "--format=3D")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *modified =3D NULL;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 revs->verbose_header =3D=
 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (arg[9] =3D=3D ':') {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 modified =3D xmalloc(strlen(arg+9) + 7 + 1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strcpy(modified, "tformat");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 strcat(modified, arg+9);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 get_commit_format(modifi=
ed ? modified : arg+9, revs);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free(modified);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct strbuf fmt =3D STRBUF_INIT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0revs->verbose_header =3D 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_addf(&fmt, "tformat:%s", arg + 9);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0get_commit_format(fmt.buf, revs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0strbuf_release(&fmt);

Ah, I felt there must be a utility like that but I couldn't find
examples of that. Thanks.

--=20
=46elipe Contreras
