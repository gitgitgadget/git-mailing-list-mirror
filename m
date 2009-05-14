From: Josh Micich <josh.micich@gmail.com>
Subject: Re: [PATCH 1/3] '--missing' option for mktree: re-added 
	strbuf_release(&p_uq), Updated man page
Date: Thu, 14 May 2009 12:44:10 -0700
Message-ID: <a644352c0905141244v4c8bdef6t69318152dc02c6a@mail.gmail.com>
References: <loom.20090514T050424-673@post.gmane.org>
	 <loom.20090514T050742-791@post.gmane.org>
	 <7vprecxlrw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Josh Micich <josh.micich@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 21:44:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4gqw-0003QL-FF
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 21:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbZENToM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 15:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbZENToL
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 15:44:11 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:18952 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbZENToJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 15:44:09 -0400
Received: by an-out-0708.google.com with SMTP id d40so3080292and.1
        for <git@vger.kernel.org>; Thu, 14 May 2009 12:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/Wn3Tn2Nb28dJCYiRbceIvG5gW5W2cJVfEd8aw2OLN0=;
        b=m6aBEj86tZowdyen2AfC01OahzIfAyb9xpCsxNkgh7XsI6f/k6V94BYzQ1x3QCeetn
         gqc0XPPbz/crzfqTomkuXA8vUtVwXdBdLwi2j7LYwO5aHgCRNgsEXWlcUCZGZvfRhLFM
         PrnFHodpGEzCrQlT/vanYBink5TykxV3Ur+5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PIPCx9bswtkXbunzrc4SnfFT6ViTV8WC0V8AMmVzYsM7AK7+ua1abxxyfoMKMQXA5Q
         hsqIuQBhTik/uBHYWe+Jl5P54ylhslWtnt5CVLwmwXOvNTWiHcFWx/VUp06qUPh3EmqY
         8nSz5byl536Czsv5BlC+RNHL/AqmxvmfzXv5E=
Received: by 10.100.5.12 with SMTP id 12mr3425683ane.15.1242330250409; Thu, 14 
	May 2009 12:44:10 -0700 (PDT)
In-Reply-To: <7vprecxlrw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119215>

On Wed, May 13, 2009 at 11:04 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 path =3D strbuf_detach(&p_uq, NULL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 append_to_tree(mode, sha1, path);
>> + =A0 =A0 =A0 =A0 =A0 =A0 strbuf_release(&p_uq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 append_to_tree(mode, sha1, path);
>> =A0}
>
> Ehh, why? =A0detach already detaches the allocated buffer from strbuf=
 and
> there is nothing to clean up by strbuf_release().
>
My bad. While re-basing my work to fe0bb5, the strbuf_release() call
went missing, but I didn't notice you had also changed:
-                       path =3D p_uq.buf;
+               path =3D strbuf_detach(&p_uq, NULL);
That is much nicer
