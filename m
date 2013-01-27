From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Sun, 27 Jan 2013 09:37:12 +0100
Message-ID: <5104E738.602@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6?= =?ISO-8859-1?Q?r=F0_Bjarmason?= 
	<avarab@gmail.com>, Chris Hiestand <chiestand@salk.edu>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 27 09:37:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzNkK-0005XI-EL
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 09:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab3A0IhT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 03:37:19 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:58364 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756220Ab3A0IhS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jan 2013 03:37:18 -0500
X-AuditID: 1207440c-b7fde6d00000088a-8f-5104e73c9d32
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A0.2F.02186.C37E4015; Sun, 27 Jan 2013 03:37:17 -0500 (EST)
Received: from [192.168.69.140] (p57A25FD5.dip.t-dialin.net [87.162.95.213])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0R8bCSv009017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 27 Jan 2013 03:37:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsUixO6iqGv7nCXQ4MgrRovjT6+zWKx9dofJ
	Yvv2LkaLrivdTBYNvVeYLS59Xs9q0fikyGL14zvsDhweO2fdZfeY+OU4q8fFS8oeN653M3p8
	3iTnceDyY7YAtihum6TEkrLgzPQ8fbsE7owbJ5cwFfQqVjRP28DewNgt3cXIySEhYCKx98xk
	FghbTOLCvfVsXYxcHEIClxklnl+/zgzhnGGS2P1vIxtIFa+AusSjvlawDhYBVYknzRcYQWw2
	AV2JRT3NTCC2qECYRO/rc4wQ9YISJ2c+AasXAarZ9ewq2AZmgd9MEmdW3AdLCAu4SrS1dbOC
	2MwCOhLv+h4wQ9jyEtvfzmGewMg3C8msWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEv
	L7VI11AvN7NELzWldBMjJLh5djB+WydziFGAg1GJh/dXGkugEGtiWXFl7iFGSQ4mJVHeWfeA
	QnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR451cC5XhTEiurUovyYVLSHCxK4ryqS9T9hATSE0tS
	s1NTC1KLYLIyHBxKErxJz4AaBYtS01Mr0jJzShDSTBycIMO5pESKU/NSUosSS0sy4kHRF18M
	jD+QFA/Q3iiQdt7igsRcoChE6ylGY479T9qfM3Js/w0khVjy8vNSpcR5q0FKBUBKM0rz4BbB
	0torRnGgv4V5K0GqeIApEW7eK6BVTECrsnuZQVaVJCKkpBoYl+6pu1WgqbtMceOc7nsXCmy0
	/y5/eZ9b/X3+g86kiRdFew3kT3x75bGw/fKH8op3P2bZ22ya8SQsYete177wFxcv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214686>

A while ago, I submitted an RFC for adding a new email notification
script to "contrib" [1].  The reaction seemed favorable and it was
suggested that the new script should replace post-receive-email rather
than be added separately, ideally with some kind of migration support.

I've been working on this on and off since then and I think it is time
for another iteration.  I think I have addressed most of the points
raised earlier, including a migration script and specific migration
instructions.

Review of main advantages of git-multimail over post-receive-email:

* Can (optionally) send a separate email for each new commit (in
addition to the emails for each reference change).

* More flexible configuration, including out-of-the-box support for
running under gitolite.

* Fixed algorithm for detecting "new" commits.

* More information in emails (e.g., commit log subject lines, telling
when a push discards old commits)j.

* Written in Python rather than shell.  Easier to extend.

Summary of improvements since the first version:

* Rename the project from the cumbersome "post-receive-multimail.py" to
"git-multimail".

* Push the project into a subdirectory and break it into multiple files
(script, docs, etc).

* Vastly improve the documentation and separate it out of the script
into a README file.

* Add a migration script, migrate-mailhook-config, that converts a
post-receive-email configuration into a git-multimail configuration.
Document the migration procedure and differences between the two scripts
in README.migrate-from-post-receive-email.

* Store the configuration options in namespace "multimailhook.*" rather
than "hooks.*".  (The post-receive-email script's use of a too-generic
top-level name was IMHO a bad idea, so fix it now.)

* Allow the feature of sending a separate email for each individual
commit to be turned off via a configuration option (to better support
post-receive-email migrants).

* Re-implement the feature of showing a short log of commits in
announcement emails, configurable via an option.

* Make it possible to import the main code as a Python module to allow
most customization to be done via Python code without the need to edit
the original file.  (Note for existing users: the Environment API has
changed since the original RFC, but I will try to keep it stable from
now on.)

* Allow the config settings that define recipient lists to be multivalued.

* Added some testing infrastructure (though the tests are still very
limited).

* Add "Auto-Submitted" headers to emails (as implemented for
post-receive-email by Chris Hiestand).

* Add option to truncate email lines to a specified length (suggested by
Matthieu Moy).  By default, this option is *on* and set to 500 characters.

* Add option to force the main part of the email body to be valid UTF-8,
with invalid characters turned into the Unicode replacement character,
U+FFFD.  By default, this option is *on* (arguments for turning it off
by default are welcome).

The code is in its own GitHub repository:

    https://github.com/mhagger/git-multimail

The script should work with any Python 2.x starting with 2.4, though I
haven't actually tested older Python versions.  It does not yet support
Python 3.x.

If it is accepted for the git project, then I would prepare a patch that
drops the git-multimail project's "git-multimail" subdirectory into the
git project as contrib/hooks/git-multimail and optionally deletes the
old post-receive-email script.  I am flexible about whether future
development should occur directly in the git project's repository or in
the git-multimail repo with occasional code drops to the git project.  I
am also flexible about whether the rough little test scripts should be
included in the git project or kept separate.

It would be very helpful if people would test this script in their own
environments and give me feedback/bug reports.  It is rather awkward to
simulate all of the possible environment scenarios myself.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/201433

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
