From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Multiblobs
Date: Fri, 30 Apr 2010 13:32:39 -0400
Message-ID: <z2p32541b131004301032jd28b4b0azbb600880f4e15871@mail.gmail.com>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com> 
	<loom.20100428T204406-308@post.gmane.org> <4BDA9F5C.2080808@itaapy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Herv=E9_Cauwelier?= <herve@itaapy.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 19:35:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7u7V-0003qm-O0
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 19:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758828Ab0D3RdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Apr 2010 13:33:08 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43817 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758825Ab0D3RdA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Apr 2010 13:33:00 -0400
Received: by vws19 with SMTP id 19so380284vws.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 10:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=BAB5BKLaufRtwS1hyV9Mv81ln9wcCDg0N2LlYUbpPh4=;
        b=lQlgy9+a/MFtrynvAOxpTKiR739YkeV1sbYk0AAfLn2Ny0HhZ/Kdz2baqWOoyR/SyD
         oJTrsKBWBxYWcqXD2MP/TliPvqmUfv3PAwWxRCHYngYvILwHL+Ub2QHPuTNcd4FGEE/y
         NW+LWHy1n/qKyhunzvotMYPSnTsvqlsO3aOo0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=xlTHib/nr5zMibwn8MG84zEafuMJW24GkCLM5DibbMJ8PvyD98v5KDtTveYbGoyAq9
         dhRutWvim19mPmcJHrBiJ7f6H99u/JdJV/xyVrH2c0qjqjr7H80CUeEDcoq/e9afKxyQ
         FFVbYYE1l1EhPCwlJl53y3XImrLzhKNgHeTiI=
Received: by 10.220.48.22 with SMTP id p22mr7919098vcf.213.1272648779338; Fri, 
	30 Apr 2010 10:32:59 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Fri, 30 Apr 2010 10:32:39 -0700 (PDT)
In-Reply-To: <4BDA9F5C.2080808@itaapy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146037>

2010/4/30 Herv=E9 Cauwelier <herve@itaapy.com>:
> I'll obviously let the Git experts answer you, but I can answer about
> OpenDocument itself.
>
> In a presentation each slide is a <draw:page/> inside a single conten=
t.xml.
> So if you change one slide, the whole XML will serialize with a diffe=
rent
> SHA.
>
> And maybe you'll add style to that slide, or probably OpenOffice.org =
will
> generate an automatic style, so styles.xml will also change. Adding a=
n image
> also changes manifest.xml, along with storing the image itself. OOo w=
ill
> surely record the last slide displayed when closing the application, =
so
> settings.xml will change too.
>
> So, all in all, for a single slide, 30 to 80 % of the Zip content may
> change.

Sure.  But if you name the chunks consistently, git's delta
compression can deal with tiny changes like those very easily.

The question is whether it'll work equally well, or better, or worse,
with a one-big-file format.  I think we won't know this without doing
some actual tests.

(Normally, you could assume that one-big-file is the most
space-efficient storage format, because then xdelta and gzip have the
most data to work with.  But if you have a lot of *duplicated* content
inside the same file, and the distance between duplications is outside
the gzip window, you could find that more unusual methods - like the
method used by bup - results in better compression.  I know this is
true for VM images, so it may be true for other things.  I haven't
tested everything :))

> You may also be interested in the git-bigfiles project that was menti=
oned
> last week.
>
> http://caca.zoy.org/wiki/git-bigfiles

git-bigfiles is a worthwhile project.  Its goal of "make life
bearable" is aiming kind of low, though.  Basically they seem to be
aiming simply to make git not die horribly when given lots of large
files.  This is commendable, but the resulting repo will be very space
inefficient when your large files change frequently in small ways.  So
I think it doesn't solve the problem Sergio brought up.

Have fun,

Avery
