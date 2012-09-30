From: Hugh Esco <hesco@campaignfoundations.com>
Subject: bug report, v1.7.12.1 -- Documentation/gitcredentials.xml:180:
 parser error
Date: Sun, 30 Sep 2012 04:27:31 -0400
Organization: CampaignFoundations.com
Message-ID: <20120930042731.d8e2086d.hesco@campaignfoundations.com>
Reply-To: Hugh Esco <hesco@campaignfoundations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 10:28:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIEtD-0006Ew-86
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 10:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886Ab2I3I21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 04:28:27 -0400
Received: from mail.greens.org ([207.111.216.211]:60091 "EHLO mail.greens.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688Ab2I3I2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 04:28:21 -0400
Received: by mail.greens.org (Postfix, from userid 2012)
	id D6B9E805D4; Sun, 30 Sep 2012 01:28:20 -0700 (PDT)
Received: from debianmarcus9.campaignfoundations.com (localhost [127.0.0.1])
	by martin.campaignfoundations.com (Postfix) with SMTP id D704B88AE
	for <git@vger.kernel.org>; Sun, 30 Sep 2012 04:27:31 -0400 (EDT)
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; i486-pc-linux-gnu)
X-Relay-for-martin: 2740427317372
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206684>

doing a source install of git v1.7.12.1, 
on the `make all doc` step, I get:

    XMLTO gitcredentials.7
xmlto: input does not validate (status 1)
/usr/local/git-git-51993a4/Documentation/gitcredentials.xml:180: parser error : Opening and ending tag mismatch: emphasis line 180 and literal
<literal>credential.<emphasis role="strong"></literal> (which applies to all cre
                                                      ^
/usr/local/git-git-51993a4/Documentation/gitcredentials.xml:181: parser error : Opening and ending tag mismatch: literal line 181 and emphasis
<literal>credential.&lt;url&gt;.</emphasis></literal>, where &lt;url&gt; matches
                                           ^
make[1]: *** [gitcredentials.7] Error 1
make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
make: *** [doc] Error 2
pbx:/usr/local/git-git-51993a4# diff Documentation/gitcore-tutorial.xml ~hesco/gitcore-tutorial.xml 
824c824
< (notice the asterisk <literal></literal> character), and the first column for
---
> (notice the asterisk <literal><emphasis role="strong"></literal> character), and the first column for
828c828
< All of them have non blank characters in the first column (<literal></literal>
---
> All of them have non blank characters in the first column (<literal></emphasis></literal>
1263c1263
< <note><simpara>You will see two files, <literal>pack-.pack</literal> and <literal>pack-.idx</literal>,
---
> <note><simpara>You will see two files, <literal>pack-<emphasis role="strong">.pack</literal> and <literal>pack-</emphasis>.idx</literal>,

-------------------------------------------
and the patch which permitted me to proceed
-------------------------------------------

180,181c180,181
< <literal>credential.</literal> (which applies to all credentials), or
< <literal>credential.&lt;url&gt;.</literal>, where &lt;url&gt; matches the context as described
---
> <literal>credential.<emphasis role="strong"></literal> (which applies to all credentials), or
> <literal>credential.&lt;url&gt;.</emphasis></literal>, where &lt;url&gt; matches the context as described

And with the resolution of this bug, 
the `make doc all` completed without further error.  

Not sure if my version of the xml parser does not recognize 
the emphasis tag, although many of these involved overlapping 
tags and sometimes I saw tags which wrapped literally nothing 
at all.  Have no idea what that might have been about.  

-- 
Hugh Esco 
skype: hresco3_ ; 678-921-8186 x21 
http://www.CampaignFoundations.com/
Providing Application Hosting, Telephony, 
Custom Development and Consulting Services 
to Green Candidates, Green Parties and
the non profits working for a just and sustainable future.

if( $insurance->rationing() ) { $people->die(); }
if( isa_ok($self,'Troy::Davis') =~ m/^ok/) { $people->are_whole(); }
