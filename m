From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH v2] Make sure objects/pack exists before creating a new 
	pack
Date: Thu, 26 Feb 2009 11:19:02 +0000
Message-ID: <e2b179460902260319je8ce6c6qc028d260b9d35b7c@mail.gmail.com>
References: <49A428B7.4000003@spiralti.com>
	 <7v7i3fivx2.fsf@gitster.siamese.dyndns.org>
	 <7vocwrc7oe.fsf_-_@gitster.siamese.dyndns.org>
	 <49A65EBF.10307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>,
	Rafael Darder Calvo <rdarder@spiralti.com>
To: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 12:20:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LceI7-00048u-Jm
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 12:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbZBZLTH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 06:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754013AbZBZLTH
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 06:19:07 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:32184 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622AbZBZLTF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 06:19:05 -0500
Received: by qw-out-2122.google.com with SMTP id 5so882629qwi.37
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 03:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RQyqSBQFD4b4xKdJiVJjbwsPh8Txdh7zk0FhmFE7B4Q=;
        b=uHvJjt5J8rfPpkH/jSQA7kWdXPVfDtGMDfcnsRl4mBbN/qJJuy3S/KIgbU8Z7YgT4w
         OEHVS/PTUk0+/Z5JeHZty3BmxrjrHejOVcoT8WCaAOz118EpvHHVjRLKB20JanVDZuGg
         7ugWLnFF5eYxx7WfBwvY8Bx6xWCQmTOi47IIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IxtO5VkePN7xy9L1ocnKOHZ+aGP/GmK+ft2TZd3BJb+OwU3slhGauh4IunpPXLs6rF
         Fl+tk74P8Dnx/elgVzISMXBEkd6JujHHCxvc4rsQDPTC/yS8XopbziH4h02MbAsn7zS1
         64kZHrWT/x6XLN3syWL6yOdLP92ZvmEPjxvhY=
Received: by 10.224.67.66 with SMTP id q2mr1916256qai.261.1235647142364; Thu, 
	26 Feb 2009 03:19:02 -0800 (PST)
In-Reply-To: <49A65EBF.10307@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111554>

2009/2/26 Johannes Sixt <j.sixt@viscovery.net>
>
> Junio C Hamano schrieb:
> > @@ -795,22 +794,24 @@ static void final(const char *final_pack_name=
, const char *curr_pack_name,
> >
> > =C2=A0 =C2=A0 =C2=A0 if (keep_msg) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int keep_fd, keep_=
msg_len =3D strlen(keep_msg);
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!keep_name) {
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0get_object_directory(), sha1_to_h=
ex(sha1));
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 keep_name =3D name;
>
> You should not have removed this line...

Even with j6t's patch, I'm seeing failures in t5300--pack-object.sh on =
AIX 5.3

* FAIL 15: survive missing objects/pack directory
fatal: Unable to create temporary file (): No such file or directory

=46rom a bit of instrumenting (no working gdb here), I see that in
wrapper.c/odb_mkstemp, template is empty on entry, empty before the
call to safe_create_leading_directories, but contains
=2Egit/objects/pack/tmp_pack_XXXXXX after the second snprintf. TMPDIR i=
s
not set here, which I thought might be the root cause, but it doesn't
seem to be that.

My naive solution is to:

index b07cdf2..80fee48 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -268,9 +268,9 @@ int odb_mkstemp(char *template, size_t limit,
const char *pattern)
                return fd;

        /* slow path */
-       safe_create_leading_directories(template);
        snprintf(template, limit, "%s/%s",
                 get_object_directory(), pattern);
+       safe_create_leading_directories(template);
        return xmkstemp(template);
 }

Which then passes all tests.

Bearing in mind that for me, fiddling with C is like trying to order
room service in Latin, if this is in any way the correct thing to do,
I'll post a proper patch with s-o-b if required, or you can just
squash into j6t's.

Mike
