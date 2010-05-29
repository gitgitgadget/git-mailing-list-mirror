From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/7] Add buffer pool library
Date: Sat, 29 May 2010 03:51:24 -0500
Message-ID: <20100529085124.GA6847@progeny.tock>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
 <1274650832-7411-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 10:51:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIHlF-0004Co-Sk
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 10:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541Ab0E2IvE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 May 2010 04:51:04 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:52065 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957Ab0E2IvA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 04:51:00 -0400
Received: by ywh36 with SMTP id 36so1324136ywh.4
        for <git@vger.kernel.org>; Sat, 29 May 2010 01:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MrBBujv54CtDjJzX/TfKpNwEvX8HNDCciarNWohMMcE=;
        b=GUQDyXtge2R/2hiTxTUhaqtrGu6i30FgiyI8JcmNm2AVOScUDEGC79Q2Pg5ieWxX9C
         F5OCq7JRbwaSAl5VkNwoiei9Gw9/BUbmzc11aL/LlOxwX3pnOjI40V+W0UTf1ByIa5+1
         SHezwdMzinQT5TaK+K3d74z/EPQocsz35xgWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PkVLctTOMRpGBY6YWDRmSnSA67U1AjV7OtwpsZMYO3xBi3jkhm6LBP406krbjzbLc7
         J1QlUqiL9a2AX/H+GbRh8u1CLO2Rhcr+Gl0uIHzJrV5371xfnOD9i36oQdV0yQ2qAWsG
         1p+hycEIAF9++IvCYD613Mph043v4ksaf8bZk=
Received: by 10.231.148.145 with SMTP id p17mr1917599ibv.28.1275123059687;
        Sat, 29 May 2010 01:50:59 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm15059178ibl.16.2010.05.29.01.50.57
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 01:50:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1274650832-7411-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147960>

Hi Ram,

Ramkumar Ramachandra wrote:

> line_buffer creates a couple of static buffers and expose an API for
> using them.

So this provides a thread-unsafe fgets() and fread() where the caller
does not have to supply a buffer.  Sounds convenient.

> Taken directly
> from David Michael Barr's svn-dump-fast-export repository.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Missing From: line and sign-off.

[...]
> +char *buffer_read_line(void)
> +{
> +    char *end;

style nitpick: use tabs to indent.

> +    uint32_t n_read;
> +
> +    if (line_len) {
> +        memmove(line_buffer, &line_buffer[line_len],
> +                line_buffer_len - line_len);
> +        line_buffer_len -=3D line_len;
> +        line_len =3D 0;
> +    }
> +
> +    end =3D memchr(line_buffer, '\n', line_buffer_len);
> +    while (line_buffer_len < LINE_BUFFER_LEN - 1 &&
> +           !feof(stdin) && NULL =3D=3D end) {
> +        n_read =3D
> +            fread(&line_buffer[line_buffer_len], 1,
> +                  LINE_BUFFER_LEN - 1 - line_buffer_len,
> +                  stdin);
> +        end =3D memchr(&line_buffer[line_buffer_len], '\n', n_read);
> +        line_buffer_len +=3D n_read;
> +    }

Why not fgets()?

[...]
> +char *buffer_read_string(uint32_t len)
> +{
> +    char *s =3D malloc(len + 1);
> +    uint32_t offset =3D 0;
> +    if (line_buffer_len > line_len) {
> +        offset =3D line_buffer_len - line_len;
> +        if (offset > len)
> +            offset =3D len;
> +        memcpy(s, &line_buffer[line_len], offset);

So if this buffer library is in use, all input needs to pass through
it?  I would prefer to avoid that if possible.

> +        line_len +=3D offset;
> +    }
> +    while (offset < len && !feof(stdin)) {
> +        offset +=3D fread(&s[offset], 1, len - offset, stdin);
> +    }

On error, wouldn=E2=80=99t this be an infinite loop?  Maybe:

  offset +=3D fread(&s[offset], 1, len - offset, stdin);
  if (ferror(stdin)) {
	free(s);
	return NULL;
 }

One iteration should be sufficient, since fread loops internally.

[...]
> +void buffer_copy_bytes(uint32_t len)
> +{
> +    uint32_t in, out;
> +    if (line_buffer_len > line_len) {
> +        in =3D line_buffer_len - line_len;
> +        if (in > len)
> +            in =3D len;
> +        out =3D 0;
> +        while (out < in && !ferror(stdout)) {
> +            out +=3D
> +                fwrite(&line_buffer[line_len + out], 1, in - out, st=
dout);
> +        }

Likewise.

> +        len -=3D in;
> +        line_len +=3D in;
> +    }
> +    while (len > 0 && !feof(stdin)) {
> +        in =3D len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
> +        in =3D fread(byte_buffer, 1, in, stdin);
> +        len -=3D in;
> +        out =3D 0;
> +        while (out < in && !ferror(stdout)) {
> +            out +=3D fwrite(&byte_buffer[out], 1, in - out, stdout);

Likewise.

Why isn=E2=80=99t line_buffer used here?

[...]
> +void buffer_skip_bytes(uint32_t len)
> +{
[...]
> +    while (len > 0 && !feof(stdin)) {
> +        in =3D len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
> +        in =3D fread(byte_buffer, 1, in, stdin);
> +        len -=3D in;
> +    }

Likewise.

Too bad stdio does not supply a function for this (fseek is the
closest I can find, and it does not work on unseekable files).

Thanks,
Jonathan
