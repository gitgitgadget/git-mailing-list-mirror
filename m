From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git-send-email.perl defect: address missing trailing > accepted
Date: Wed, 21 Oct 2009 00:29:55 +0200
Message-ID: <40aa078e0910201529m338ef3d1o4fa1a31c3dcc2a20@mail.gmail.com>
References: <1256076767.2029.59.camel@Joe-Laptop.home>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 00:30:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0NDP-0002eP-6V
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 00:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbZJTW3x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 18:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbZJTW3x
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 18:29:53 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:39880 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbZJTW3w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 18:29:52 -0400
Received: by fxm18 with SMTP id 18so7014640fxm.37
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PbQqlAm5bMPisEoE4BAQ4DZ4ZkC6OQsa2vV0Uoq2w0w=;
        b=lW9BRBd/Wg5NnPfZurz87BynjPk9ZPfMAVXBj81Mfon7qu/DNaFc1xUZRIM1r7+O0k
         DTU981NXlkUocQKMDvDDNHHcz1ebX2OMwIp/tuWsLGvJ95mgwgQMH37ZV067zt73peiv
         4qy9U9yb8rgKxpnIkLf+XjbwbQqlG1JAv8XpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=AO9fWksvwwfjxONx4gDBNWkdAy13+rx1cMh+AFkCa3BmcdGVLE/sfmn+WeP7tfwz1G
         obZen7sCdv3PGlW0PJHAKOG6YbobPdWMmawN6UMzMvqn56By5jk+Cv1RVuPipq6A5Jyv
         Xl/svZeVpZCiJJ1fJD+Py5GkT+9iOfy0FZL38=
Received: by 10.204.162.210 with SMTP id w18mr7222119bkx.174.1256077795292; 
	Tue, 20 Oct 2009 15:29:55 -0700 (PDT)
In-Reply-To: <1256076767.2029.59.camel@Joe-Laptop.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130860>

On Wed, Oct 21, 2009 at 12:12 AM, Joe Perches <joe@perches.com> wrote:
> I typo cut/pasted an invalid email address,
> neglecting to copy the trailing ">".
>
> was: =A0 =A0"Name <addr.org"
> needed: "Name <addr.org>"
>
> Anyone have suggestions on how to get
> git-send-email.perl to notify and abort
> sending on more invalid address styles?

Something along these lines? Of course, the error message is, uhm,
less than helpful :)

--->8---
diff --git a/git-send-email.perl b/git-send-email.perl
index f5ba4e7..83f5e80 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -787,6 +787,10 @@ sub is_rfc2047_quoted {
 sub sanitize_address
 {
 	my ($recipient) =3D @_;
+	if ($recipient =3D~ m/.*<[^>]*$/) {
+		die "EEK!"
+	}
+
 	my ($recipient_name, $recipient_addr) =3D ($recipient =3D~ /^(.*?)\s*=
(<.*)/);

 	if (not $recipient_name) {


--=20
Erik "kusma" Faye-Lund
