From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] remote tracking: return the tracking branch for  the given branches
Date: Thu, 18 Jun 2009 12:19:12 -0700
Message-ID: <7v63etnydr.fsf@alter.siamese.dyndns.org>
References: <1245311834-5290-1-git-send-email-santi@agolina.net>
	<m3iqithd24.fsf@localhost.localdomain>
	<adf1fd3d0906180655q5c142889r3375169b6cf1f8b0@mail.gmail.com>
	<200906181617.07802.jnareb@gmail.com>
	<adf1fd3d0906180740t637da9braea02deb3cba2680@mail.gmail.com>
	<adf1fd3d0906181201r5f3b2f55t8427e7be5ba07e9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 21:19:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHN8r-0003Bb-OS
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 21:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbZFRTTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 15:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753644AbZFRTTL
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 15:19:11 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:43645 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbZFRTTK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 15:19:10 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090618191913.JBNZ20976.fed1rmmtao102.cox.net@fed1rmimpo03.cox.net>;
          Thu, 18 Jun 2009 15:19:13 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 5XKC1c0064aMwMQ04XKChd; Thu, 18 Jun 2009 15:19:12 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=skTYOvjxkaUA:10 a=3yCQnsJiAAAA:8
 a=_ZrP_KuqKz5nvo8-HrQA:9 a=b60H4UHrXxvMXcezEZKLsGsWBhQA:4 a=cdoSpQTWPqQA:10
X-CM-Score: 0.00
In-Reply-To: <adf1fd3d0906181201r5f3b2f55t8427e7be5ba07e9a@mail.gmail.com>
 ("Santi =?utf-8?Q?B=C3=A9jar=22's?= message of "Thu\, 18 Jun 2009
 21\:01\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121869>

Santi B=C3=A9jar <santi@agolina.net> writes:

> One thing it just occurred to me is to return the explicit refspec
> instead of the tracking branch. So with the default config (after a
> clone):
>
> $ git remote tracking origin refs/heads/master
> refs/heads/master:refs/remotes/origin/master

I think the output is sensible, instead of saying something like
'origin/master'.

We can and should allow the end users to use abbreviated form as input =
to
us (either command line or configuration value) when it is unambiguous,
but when returning values for use by Porcelains, we should be strict an=
d
precise to avoid ambiguities.

> this makes a difference in case we want to allow returning all the
> matching tracking branch and not the first one with more than one
> branch, as:
>
> $ git config remote.origin.fetch --add +refs/heads/*:refs/remote/anot=
her/*
>
> $ git remote tracking origin refs/heads/master
> refs/heads/master:refs/remotes/origin/master
> refs/heads/next:refs/remotes/origin/next

I am not sure what this example is doing.  You asked about refs/heads/m=
aster
but you also talk about refs/heads/next?   I guess you meant to say

    $ git remote tracking origin refs/heads/master
    refs/heads/master:refs/remotes/origin/master
    refs/heads/master:refs/remotes/another/master

instead, judging from the next example?

> $ git remote tracking origin refs/heads/master refs/heads/next
> refs/heads/master:refs/remotes/origin/master
> refs/heads/master:refs/remotes/another/master
> refs/heads/next:refs/remotes/origin/next
> refs/heads/next:refs/remotes/another/next
