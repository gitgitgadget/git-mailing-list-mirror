From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git EOL Normalization
Date: Tue, 31 May 2011 11:01:02 -0400
Message-ID: <1306854062.12429.11.camel@drew-northup.unet.maine.edu>
References: <22629514.41388.1306427328539.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue May 31 17:01:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRQS3-0002WB-AK
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 17:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521Ab1EaPBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 11:01:42 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:52878 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab1EaPBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 11:01:41 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p4VF16BN016555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 May 2011 11:01:06 -0400
In-Reply-To: <22629514.41388.1306427328539.JavaMail.root@mail.hq.genarts.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=5 Fuz1=5
	Fuz2=5
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p4VF16BN016555
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1307458867.61156@fNpZvoDhG13dvsb+Q2iK8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174803>


On Thu, 2011-05-26 at 12:28 -0400, Stephen Bash wrote:
> ----- Original Message -----
> > From: "Junio C Hamano" <gitster@pobox.com>
> > To: "Jakub Narebski" <jnareb@gmail.com>
> > Sent: Thursday, May 26, 2011 12:07:21 PM
> > Subject: Re: Git EOL Normalization
> > 
> > > I think git examines only first block of a file or so. The heuristic
> > > to detect binary-ness of a file is, as I have heard, the same or
> > > similar to the one that GNU diff uses.
> > 
> > Yes, the binary detection was designed to be compatible with GNU diff. But
> > I do not think it has much to do with the topic of this thread. Aren't
> > other people discussing the line ending?
> 
> The binary detection may be apropos because there are situations
> (core.autocrlf={true,input} and text=auto) where Git will only do line
> ending conversion if it detects a text file...  But I'll leave it to
> people who know the code better to say if this binary detection is in
> fact part of the decision process.

Currently UTF-16 and UTF-32 (which many consider to be text files) are
detected as binary files by Git (due to said compatibility with GNU
diff). Therefore EOL normalization does not happen on those files. 

I have played a little with detecting (and eventually do the same for
normalizing) reasonably valid UTF-16 (BE and LE), but my code is nowhere
near ready for the big time, much less properly tested.

As for diff-ing UTF-16/UTF-32 for purely human consumption, I would be
tempted to iconv (smudge?) the text into UTF-8 and then let the diff-ing
algorithm deal with it. Not a perfect solution, but perfect should not
be the enemy of good in that case. Unfortunately this would not produce
proper patches for mailing. (As for how we'd know it is UTF-32 and not a
binary, I'll leave that for further discussion should we need it. I
suspect we'd have to trust the user. UGH.)

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
