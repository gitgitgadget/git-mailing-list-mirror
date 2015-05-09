From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: t0025 weird behaviour on NonStop ksh/bash
Date: Fri, 8 May 2015 23:11:26 -0400
Message-ID: <004e01d08a05$d6d77b60$84867220$@nexbridge.com>
References: <003101d089e5$27347610$759d6230$@nexbridge.com> <xmqqbnhuihv9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 05:11:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqvB1-00058Q-11
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 05:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbbEIDLe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 23:11:34 -0400
Received: from elephants.elehost.com ([216.66.27.132]:60706 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751389AbbEIDLd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 23:11:33 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t493BUwj022113
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 8 May 2015 23:11:31 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <xmqqbnhuihv9.fsf@gitster.dls.corp.google.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHmhBdpElHw7saNclhLqsvNo7UNlAHGt8npnTjL70A=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268695>

On May 8, 2015 10:51 PM Junio C Hamano wrote:
> > Ok, I'm sure that this is not a git problem, but there is an
> > assumption about echo behaviour in t0025 that may not be correct. When
> > executed from a shell function on the HP NonStop platform under ksh
> > and bash, the LFonly file annoyingly contains cr-lf not just lf. This
causes sub-
> test 4 to fail.
> > Weirdly, this does not happen from an interactive shell. My proposed
> > solution, in t0025-crlf-auto.sh, to this is to make it explicit that
> > bad behaviour on the part of echo should be dealt with severely, as in:
> >
> >         for w in Hello world how are you; do echo $w; done | tr -d '\r'
> >>LFonly
> >
> > instead of
> >
> >         for w in Hello world how are you; do echo $w; done >LFonly
> >
> > which is a no-op on platforms that behave themselves in this
> > situation. Is this the proper approach?
> Why on earth does "echo $w" that prints just ASCII alphabet and nothing
else
> (other than the end-of-line, of course) gives CRLF in the first place?
> 
> Is stripping with "tr -d" a sane approach?  I am not sure if it is
tackling the right
> problem.
> 
> Because we use 'echo', expecting it to behave sensibly in many other
places,
> wouldn't it be the case that all your 'tr -d' here does is to add an
unnecessary
> pipe on sane platforms for this single test script, while leaving all the
other
> uses of 'echo' in other shell scripts, including scripted Porcelains like
'git pull',
> broken on your platform?

Absolutely agree. This (being the test case) is not the problem and adding
tr -d is not a viable solution even if it appears to fix the issue at this
moment in time. Built-in and variable processing need to behave in a
normalized manner. I'm working to get that resolved; however, actually doing
a proper fix happens to be outside of my control :(.
