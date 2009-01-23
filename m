From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: git fast-import problem converting from CVS with git 1.6.1 and
 cvs2svn 2.2.0
Date: Fri, 23 Jan 2009 05:14:10 +0100
Message-ID: <49794412.8070909@alum.mit.edu>
References: <63BEA5E623E09F4D92233FB12A9F794302BC6851@emailmn.mqsoftware.com> <63BEA5E623E09F4D92233FB12A9F794302BC6855@emailmn.mqsoftware.com> <63BEA5E623E09F4D92233FB12A9F794302BC6921@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, cvs2svn users <users@cvs2svn.tigris.org>
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: users-return-1044191+gcvscu-users=m.gmane.org@cvs2svn.tigris.org Fri Jan 23 05:15:39 2009
Return-path: <users-return-1044191+gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@m.gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=sc157-tigr.sjc.collab.net)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQDSE-0006Z7-Vo
	for gcvscu-users@m.gmane.org; Fri, 23 Jan 2009 05:15:39 +0100
Received: from sc157-tigr.sjc.collab.net (localhost [127.0.0.1])
	by sc157-tigr.sjc.collab.net (Postfix) with ESMTP id 0B0417B0069;
	Thu, 22 Jan 2009 20:14:18 -0800 (PST)
Received: from localhost ([127.0.0.1])          by Mail Reader Service (JAMES SMTP Server 2.3.0) with SMTP ID 159          for <users@cvs2svn.tigris.org.mrs>;          Thu, 22 Jan 2009 20:14:16 -0800 (PST)
Received: from cylon1.sjc.collab.net (cylon1.sjc.collab.net [204.16.104.10])	by sc157-tigr.sjc.collab.net (Postfix) with ESMTP id 643017B0069	for <users@cvs2svn.tigris.org>; Thu, 22 Jan 2009 20:14:16 -0800 (PST)
Received: from einhorn.in-berlin.de ([192.109.42.8])  by cylon1.sjc.collab.net with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Jan 2009 20:14:15 -0800
Received: from [192.168.69.129] (77-21-84-251-dynip.superkabel.de [77.21.84.251])	(authenticated bits=0)	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n0N4ECvU029030	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);	Fri, 23 Jan 2009 05:14:13 +0100
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302BC6921@emailmn.mqsoftware.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
X-Enigmail-Version: 0.95.0
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20090105 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
X-Envelope-From: mhagger@alum.mit.edu
X-IRONPORT: SCANNED
X-IronPort-AV: E=Sophos;i="4.37,310,1231142400";   d="scan'208";a="19078253"
X-IronPort-Anti-Spam-Result: Ai4EAKrSeEnAbSoIgWdsb2JhbACTeQEBFiKnDIY8iDuFcw
X-IronPort-Anti-Spam-Filtered: true
List-Id: <users.cvs2svn.tigris.org>
precedence: bulk
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106830>

Kelly F. Hickel wrote:
> I found the section in question, it is:
> -- snip --
> commit refs/heads/TAG.FIXUP
> mark :1000007128
> committer cvs2svn <cvs2svn> 1002043747 +0000
> data 88
> This commit was manufactured by cvs2svn to create tag
> 'T_BU_Problem_9xxx_Merge_3-21-2000'.
> merge :1000007126
> M 100755 :180810 mfcdev/Domedit/DlgAddAlias.h
> -- snap --
> 
> By my count, 88 is the ending single quote character, leaving the '.' to
> be interpreted as a command.
> 
> Looks like I should go post this on the cvs2svn list.....

Yes, that would be helpful.  Please include enough information and data
to enable me to reproduce your problem, because it is very mysterious.

The lines in question are (in Python)

    self.f.write('data %d\n' % (len(log_msg),))
    self.f.write('%s\n' % (log_msg,))

where self.f is a file that was opened in binary mode, and log_msg is an
8-bit or unicode string.  Since the log message is being output to a
binary file, f.write() should squeal if the string includes any
non-ascii characters (I just verified this with Python 2.2, 2.4, and
2.5).  Nevertheless, I suspect that your problem is caused by some kind
of character encoding problem, perhaps dependent on platform or Python
version.

You might also try the trunk version of cvs2svn; there have been a lot
of changes to cvs2git since release 2.1.1--even a new command that is
actually called cvs2git! (though for now you still need to use an
options file to start conversions).

Michael

------------------------------------------------------
http://cvs2svn.tigris.org/ds/viewMessage.do?dsForumId=1670&dsMessageId=1044191

To unsubscribe from this discussion, e-mail: [users-unsubscribe@cvs2svn.tigris.org].
