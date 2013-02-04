From: Marc Khouzam <marc.khouzam@ericsson.com>
Subject: RE: [PATCH] Handle path completion and colon for tcsh script
Date: Mon, 4 Feb 2013 02:50:58 +0000
Message-ID: <E59706EF8DB1D147B15BECA3322E4BDC09B5A4@eusaamb103.ericsson.se>
References: <E59706EF8DB1D147B15BECA3322E4BDC09AA38@eusaamb103.ericsson.se>
 <7vboc2bhpj.fsf@alter.siamese.dyndns.org>
 <510EC1A4.4000207@gmail.com>,<7vhalt86wj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 03:51:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2C9V-0004D3-AT
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 03:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753932Ab3BDCvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 21:51:02 -0500
Received: from usevmg21.ericsson.net ([198.24.6.65]:50114 "EHLO
	usevmg21.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab3BDCvA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Feb 2013 21:51:00 -0500
X-AuditID: c6180641-b7f926d000000e79-80-510f2213c99e
Received: from EUSAAHC001.ericsson.se (Unknown_Domain [147.117.188.75])
	by usevmg21.ericsson.net (Symantec Mail Security) with SMTP id 71.28.03705.3122F015; Mon,  4 Feb 2013 03:50:59 +0100 (CET)
Received: from EUSAAMB103.ericsson.se ([147.117.188.120]) by
 EUSAAHC001.ericsson.se ([147.117.188.75]) with mapi id 14.02.0318.004; Sun, 3
 Feb 2013 21:50:59 -0500
Thread-Topic: [PATCH] Handle path completion and colon for tcsh script
Thread-Index: Ac4BfS+gNnq/8K09SGSiydPZlwP+xgABB1VoADxl1QD//7idbYAAXjBU
In-Reply-To: <7vhalt86wj.fsf@alter.siamese.dyndns.org>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.117.188.134]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsUyuXSPt66wEn+gwfZeY4uuK91MFg29V5gt
	Lv7pYndg9tg56y67x8VLyh6fN8kFMEdx2aSk5mSWpRbp2yVwZRx5/JW9YIlCxbOvG9kaGHdK
	dDFyckgImEjcaD7GDGGLSVy4t56ti5GLQ0jgCKPElpOXGCGcZYwSX99eYASpYhPQk7jx8xY7
	iC0iECwx//tDFhCbWUBf4tOfA0wgtrCAq8Tf97OYIWrcJA6cmw80lQPMvrWaEyTMIqAi8e/c
	TrCRvALeEt9+72eB2HWAUeJkzyU2kASngJnE1dlzwHYxCshK7D57nQlil7jEvvm7oa4WkFiy
	5zyULSrx8vE/VghbWWLJk/1Qt+lILNj9iQ3C1pZYtvA1M8RiQYmTM5+wTGAUm4Vk7CwkLbOQ
	tMxC0rKAkWUVI0dpcWpZbrqR4SZGYNwck2Bz3MG44JPlIUZpDhYlcd5Q1wsBQgLpiSWp2amp
	BalF8UWlOanFhxiZODilGhiF7rJUfSv72Hr+vQaT95OMkxtef016FBLbOu11o2lh9Y005h+X
	+TXzyhaKWNXWRgU7GsQ17lJi0p/4/FNRI8/q7LL8drPcvUzOT6pMzjJ28/o9OpKdUqS70bj/
	xKxeRSO+Q0fL6mobf4uHuB65rvpqwsbTAQ9Db8YzaGXZ9nHWPlHmsv4frMRSnJFoqMVcVJwI
	AL2FLkxpAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215349>

> > The problem is, if the directory name *already* has a slash, Bash adds
> > another slash!
> 
> So bash users do see the trailing slash because bash adds one to
> what we compute and return, which we do strip the trailing slash
> exactly because we know bash will add one.  

The problem is slightly more obscure than that, and I wonder if it
should be documented somewhere in the bash script?
Manlio explained in a previous
exchange with me, that bash will properly deal with an existing
trailing slash when doing the completion on the command-line, but
will screw it up by adding a second slash when dealing with multiple
possible completions and printing those for the user to choose from.

For example:

$ git status
# On branch tcsh_next
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       fish/
#       fishing/
nothing added to commit but untracked files present (use "git add" to track)

$ git add fish<tab>
fish//    fishing//            <-------- notice the double slashes

$ git add fishi<tab>

# will complete the command line properly to the below, with a single slash.

$ git add fishing/



> Because tcsh completion
> uses what we compute directly, without bash massaging our output to
> add the trailing slash, it needs some magic.

Yes, that is right.

> OK, that makes sense.  It was this part from the originally proposed
> log message:
> 
> >> ... Such completions do not add the '/' at the end of directories
> >> for recent versions of bash.  However, the '/' is needed by tcsh,
> >> ...
> 
> with a large gap between the two sentences that fooled me, and the
> explanation in your message helped to fill the gap to understand the
> situation better.

Sorry about the lack of details.
I'm see more and more the importance of these commit messages :)

> Perhaps
> 
>         ... for recent versions of bash, which will then add the
>         trailing slash for paths that are directory to the result of
>         our completion.  The completion for tcsh however uses the
>         result of our completion directly, so it either needs to add
>         the necessary slash itself, or needs to ask us to keep the
>         trailiing slash.  This patch does the latter.
> 
> or something?

How about the following, which gives a little more detail about
the solution for tcsh?  I think it is worth putting the below extra
details because I feel a mistake could easily be made about this
trailing slash issue, which I had gotten wrong for my own version
of the script for a couple of weeks, before figuring out the mistake.


    Handle path completion and colon for tcsh script
    
    Recent enhancements to git-completion.bash provide
    intelligent path completion for git commands.  Such
    completions do not provide the '/' at the end of directories
    for recent versions of bash; instead, bash itself will add the
    trailing slash to directories to the result provided by 
    git-completion.bash.  However, the completion for tcsh uses
    the result of the bash completion script directly, so it either 
    needs to add the necessary slash itself, or needs to ask the
    bash script to keep the trailing slash.  Adding the slash itself
    is difficult because we cannot easily tell if an entry of the 
    output of the bash script is a directory or something else.
    For example, assuming there is a directory named 'commit'
    in the current directory, then, when completing
      git add commit<tab>
    we would need to add a slash, but for
      git help commit<tab>
    we should not.
    Figuring out such differences would require adding much
    intelligence to the tcsh completion script.  Instead, it is 
    simpler to ask the bash script to keep the trailing slash.
    This patch does this.
    
    Also, tcsh does not handle the colon as a completion
    separator so we remove it from the list of separators.
    
    Signed-off-by: Marc Khouzam <marc.khouzam@ericsson.com>

Thanks

Marc
