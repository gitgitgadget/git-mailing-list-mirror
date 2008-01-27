From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] showing commiter and parent commit(s) on the revision detail viewer
Date: Sun, 27 Jan 2008 01:34:10 +0100
Message-ID: <200801270134.11892.robin.rosenberg.lists@dewire.com>
References: <1201262529-3306-1-git-send-email-rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Sun Jan 27 01:34:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIvU1-0000zF-RN
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 01:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbYA0AeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 19:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753019AbYA0AeJ
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 19:34:09 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12998 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752962AbYA0AeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 19:34:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 1509980285B;
	Sun, 27 Jan 2008 01:34:06 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SpM9zZccmOzG; Sun, 27 Jan 2008 01:34:05 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 40AFC8027FD;
	Sun, 27 Jan 2008 01:34:05 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <1201262529-3306-1-git-send-email-rogersoares@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71794>

Hi Roger,

The general idea is ok. Some minor coments though.

>Re: [EGIT PATCH] showing commiter and parent commit(s) on the revision detail viewer
"Show" and final period.

fredagen den 25 januari 2008 skrev Roger C. Soares:
> @@ -221,14 +223,16 @@ public class GitHistoryPage extends HistoryPage implements IAdaptable,
>  				if(selection2.length == 1) {
>  					// if the table item is not visible in the UI and it's selected via keyboard
>  					// this listener is called before the listener that sets the item data.
> -					if(selection2[0] == null) {
> +					GitCommitFileRevision revision = (GitCommitFileRevision) selection2[0];
> +					if(revision == null) {
>  						int ix = table.getSelectionIndex();
> -						GitFileRevision revision = (GitFileRevision) fileRevisions.get(ix);
> +						revision = (GitCommitFileRevision) fileRevisions.get(ix);
>  						selection2[0] = revision;
>  					}
> -					setRevisionInfoTextViewers(selection2[0]);
> +					setRevisionInfoTextViewers(revision);
I'm rather allergic to casts, so if we could have only one I'd feel better. Something like

					IFileRevision revision = selection2[0];
					if(revision == null) {
 						int ix = table.getSelectionIndex();
						revision = fileRevisions.get(ix);
 						selection2[0] = revision;
 					}
					setRevisionInfoTextViewers((GitCommitFileRevision)revision);

>  				}
>  
> +
two lines of whitepspace

>  		if (revisionInfo.length() == 0) {
> -			revisionInfo.append("Commit: ");
> +			revisionInfo.append("Commit ID: ");
I prefer just commit. It's shorter and that it is the id is obvious.

> +		revisionInfo.append(formatPersonIdentForRevInfo(commit.getAuthor()));
> +		revisionInfo.append("\nCommiter: ");
Two t's in "Committer"

> +				} catch (IOException e) {
> +					e.printStackTrace();
We should start doing error handling better. But that's a separate chapter. Add a // TODO for now. 
I'll address them one all one one go later, unless someone does it for me.

-- robin
