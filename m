From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Libification update
Date: Mon, 14 Nov 2005 17:31:29 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.14.16.31.28.304206@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Nov 14 17:40:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhKF-00043U-8f
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbVKNQg4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVKNQg4
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:36:56 -0500
Received: from main.gmane.org ([80.91.229.2]:19903 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751167AbVKNQgz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 11:36:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EbhGk-0002B9-KF
	for git@vger.kernel.org; Mon, 14 Nov 2005 17:33:22 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 17:33:22 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 17:33:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11812>

I've merged my current library-ification effort with Junio's current HEAD.

URL: http://netz.smurf.noris.de/git/git.git#libize

There's a Python interface, written using Pyrex. You can now walk object
trees natively, with Python:

>>> import git
>>> e=git.env()
>>> db=e.objdb
>>> c=db.lookup("HEAD").parent[0] # "HEAD^" will work too
>>> t=c.tree
>>> t.entries[0].name
'.gitignore'
>>> t["debian"].entries[0].name
'changelog'
>>> t[".gitignore"].data[0:5]
'/git\n'
>>> t[".gitignore"].data.readline()
'/git\n'    # this will work tomorrow (I hope)

I have not implemented much beyond that; keeping the code in sync is
work, so doing more will have to wait until this gets merged.

I did play with SWIG a bit. It would have simplified interfacing
languages other than Python to git. Unfortunately, there were problems: 

- refering to objects SWIG did not allocate itself is a nontrivial
  exercise
- so is keeping the Python-visible namespace clean
  (unless you're using C++ ... probably not something we'd want to subject
  the git core to ...)
- SWIG's error reporting is *scary*.
  In comparison, Pyrex mostly does the right thing.

If somebody wants to start working on a SWIG/perl/tcl/... interface
for the library, be my guest. ;-)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Ask the person next to you.
