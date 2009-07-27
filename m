From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: RE: Question about fixing windows bug reading graft data
Date: Mon, 27 Jul 2009 12:33:50 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F7943033B2744@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794303117E06@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Kelly F. Hickel" <kfh@mqsoftware.com>, <git@vger.kernel.org>,
	<Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 27 19:49:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVUKH-0005A5-RZ
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 19:49:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385AbZG0RtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 13:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbZG0RtV
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 13:49:21 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:7315 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbZG0RtU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Jul 2009 13:49:20 -0400
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2009 13:49:20 EDT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794303117E06@emailmn.mqsoftware.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Question about fixing windows bug reading graft data
Thread-Index: AcnoXU0XuqTBhzgZRw2U6H6CLjOnfAmglWxw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124174>

OK, so the 10th copy of the msysGit Herald post has shamed me out of
hiding!
I posted the below awhile back, and since I volunteered to fix something
(if given a few pointers), I felt I had "Done My Duty" to the Git world!

But now Dscho has made me rip the blinders from my eyes, to try once
again to offer to fix this bug (even though I found it in Cygwin Git and
don't use msysgit, but hey, Git is Git, right!?!?!)....

So, here I am, gonna put myself out there, willing to suffer ridicule,
etc!

Any guidance on "the Git way" to properly deal with \r in a meta
file????  Show me the light!


--

Kelly F. Hickel
Senior Product Architect
MQSoftware, Inc.
952-345-8677 Office
952-345-8721 Fax
kfh@mqsoftware.com
www.mqsoftware.com
Certified IBM SOA Specialty
Your Full Service Provider for IBM WebSphere
Learn more at www.mqsoftware.com 


> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Kelly F. Hickel
> Sent: Monday, June 08, 2009 12:20 PM
> To: git@vger.kernel.org
> Subject: Question about fixing windows bug reading graft data
> 
> Hi All,
> 	Ran into a bug trying to use grafts on windows with cygwin git
> version 1.6.1.2.  I've verified that the bug is still there in the
> latest source, and was going to submit a patch, but then I noticed
that
> there seem to be more occurrences in commit.c, and wondered if there
> was
> a better way to fix it than what I had first come up with.
> 
> The bug, is that in in commit.c, the code strips '\n', but not '\r',
so
> the code says the graft data is bad:
> struct commit_graft *read_graft_line(char *buf, int len) {
>         /* The format is just "Commit Parent1 Parent2 ...\n" */
>         int i;
>         struct commit_graft *graft = NULL;
> 
>         if (buf[len-1] == '\n')
>                 buf[--len] = 0;
>         if (buf[0] == '#' || buf[0] == '\0')
>                 return NULL;
>         if ((len + 1) % 41) {
>         bad_graft_data:
>                 error("bad graft data: %s", buf);
>                 free(graft);
>                 return NULL;
>         }
> 
> My first plan was to fix it the way that xdiff-interface.c handles it,
> assuming that was "the Git way" to deal with CRLF:
>         /* Exclude terminating newline (and cr) from matching */
>         if (len > 0 && line[len-1] == '\n') {
>                 if (len > 1 && line[len-2] == '\r')
>                         len -= 2;
>                 else
>                         len--;
>         }
> 
> But I noticed that there seemed to be several checks for '\n' in
> commit.c that didn't check for '\r', and wondered if there was a
> reason,
> or if there'd be a better way to handle it.....
> 
> 
> 
> --
> 
> Kelly F. Hickel
> Senior Product Architect
> MQSoftware, Inc.
> 952-345-8677 Office
> 952-345-8721 Fax
> kfh@mqsoftware.com
> www.mqsoftware.com
> Certified IBM SOA Specialty
> Your Full Service Provider for IBM WebSphere Learn more at
> www.mqsoftware.com
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
