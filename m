From: Nikolaus Demmel <nikolaus@nikolaus-demmel.de>
Subject: Re: git-svn show-externals and svn version
Date: Tue, 21 Feb 2012 12:14:49 +0100
Message-ID: <994D6101-DD43-4CD9-BB96-34807E3087C4@nikolaus-demmel.de>
References: <E59CCE45-6F92-4748-9B6E-2A562647904B@nikolaus-demmel.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 12:14:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzngP-00070Z-B6
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 12:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186Ab2BULOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 06:14:52 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:53089 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab2BULOv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 06:14:51 -0500
Received: from [192.168.178.100] (c-cca272d5.015-455-73746f34.cust.bredbandsbolaget.se [213.114.162.204])
	by mrelayeu.kundenserver.de (node=mrbap2) with ESMTP (Nemesis)
	id 0LoaZ0-1SfA2q0XP8-00gEoq; Tue, 21 Feb 2012 12:14:50 +0100
In-Reply-To: <E59CCE45-6F92-4748-9B6E-2A562647904B@nikolaus-demmel.de>
X-Mailer: Apple Mail (2.1084)
X-Provags-ID: V02:K0:65Fdt7iCDtcJ6beNBTG8I8MN79BlTqloPNWLlPjiY5E
 zI0Dq319XTojw+tHKTKwjHuu/BoI4tD6Bg8+v+BKWl8xe1G4dC
 Bd8l8U7e6SXvRtcPe1Kl3ywZaTTWL5lmgQJaZCY5s6o/FSPTXN
 +eM1RKkAlIHeSRfzGawOnKl8rljb3x7OvDfK4ItDLv2basncWy
 gwPxVpR3WBqipe80z3Q4nV/RIRVpM+L1I8sCo3Bl1mkhyh7/CZ
 KX0/0kko3AFnQaFg/9JsDTan9FdGbcIRj5yGK0Nk6QfNO1Z8hB
 4esR4R5w5ydH7W9z1Lkf1jALIVkjWcndo982zgaQOnvVLBnpp7
 KDvXq1fujoccvf+CyfkwcUK9+Ry2c5Y5//mSECBk0b/vJZUusV
 pNTOXjm7TeUeCpdS7c1TjSa1vh/G5zasps=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191151>

Hi,

as a followup just another example of when the current show-externals gives a flaky output, namely when the line in the external definition is commented.


$ git svn show-externals
[...]
# /src/
/src/#https://codex.cs.bham.ac.uk/svn/nah/cogx/code/subarchitectures/vision.sa/tags/matlab-cosy-2008     matlab_cosy_2008
/src/#https://codex.cs.bham.ac.uk/svn/nah/cogx/code/subarchitectures/vision.sa/tags/matlab-review-2009     matlab_review_2009


Regards,
Nikolaus


Am 19.02.2012 um 19:53 schrieb Nikolaus Demmel:

> Hi,
> 
> I am currently investigating getting support for svn externals in git-svn (you might have noticed my other mails).
> 
> It turns out that there are quite a few scripts floating around that use the output of show-externals and then try to pull these externals with git-svn into independent repositories and add the folders as submodules to the root repository.
> 
> However, none of them work for me, and the primary reason AFAICT is that they were written for the pre svn1.5 format of svn:externals. From 1.5 svn supports a new format of svn:externals, which changes the order of revision, repository-url, and local folder, and also adds the posibility to add relative urls, peg-revisions, etc [1].
> 
> On top that it seems to me that the output of show-externals was purely designed for the old format. For example, if you compare the output of "git svn show-externals" with "git svn propget svn:externals" in an example repository using the new format [2], you find that the in the show-externals output the prepended "/" and "/instantiations/" at the beginning of each line does not make sense. If the target url (all relative with the ^ syntax in this case) and the sub-folder were swapped in order, as of pre 1.5 svn, it would make much more sense. Also apparently the code for show-externals was added in 2007 and not changed since, whereas svn 1.5 was released in 2008.
> 
> What I am not completely clear about is, whether svn 1.5 and later enforces the new syntax, or whether it just adds the new syntax and still has to support the old syntax (which could be distinguished, I guess, by checking of the last part on an entry is an absolute URL instead of a subfolder). Also, I'm not sure if the format depends on the version of the svn-server or the client. I would assume you can check out a repository hosted with svn 1.4 with a 1.5 client. Does the client process the svn:externals and present it in the new format, or is this the text string just taken from the server unaltered (I have not much knowledge of how svn actually works internally)?
> 
> Another question is whether the perl svn bindings present the svn:externals in some parsed, standard format, or do they just give you the raw text string?
> 
> In order to make show-externals more useful with the svn 1.5 and later syntax, one would maybe need to check the underlying svn version. I guess it is also quite important to retain backwards compatibility, such that users of externals with the old syntax would still get the same output as before.
> 
> I would suggest that the show-externals output should be as close as possible to the svn:externals syntax, possibly adapting the subfolder path for nested folders. However here the recursive display of externals for subfolders becomes a bit more tricky, since the URL can also be relative to the subfolder as of the new syntax. Maybe the easiest way to deal with the new syntax in show-externals would be to have each line like it is in the svn-properties, but add a space separated relative path to the corresponding subfolder at the beginning. A tool that uses this is then responsible for making sure the relative URLs are resolved correctly.
> 
> To sum up, given that all the questions I have are answered like I think is most likely, it would boil down to changing the output of show-externals for svn 1.5  and later just slightly, namely by inserting an additional space between the prepended subfolder and the actual svn:externals definition in each line.
> 
> Any thoughts and/or answers?
> 
> Cheers,
> Nikolaus
> 
> 
> [1] http://svnbook.red-bean.com/en/1.7/svn.advanced.externals.html
> [2] http://paste.lisp.org/display/127858--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
