From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-mailsplit: with maildirs try to process new/ if
	cur/ is empty
Date: Tue, 6 Nov 2007 08:28:31 +0100
Message-ID: <20071106072831.GA3021@steel.home>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org> <20071026160118.GA5076@ferdyx.org> <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org> <20071105225258.GC4208@steel.home> <635FFEC2-2489-443B-8425-DF2B58BE23C2@mac.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>,
	"Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael Cohen <michaeljosephcohen@mac.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 08:28:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpIrj-0000KS-Lh
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 08:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbXKFH2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 02:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753410AbXKFH2h
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 02:28:37 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:40725 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbXKFH2g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 02:28:36 -0500
Received: from tigra.home (Facbb.f.strato-dslnet.de [195.4.172.187])
	by post.webmailer.de (fruni mo41) (RZmta 14.0)
	with ESMTP id i02208jA66KXBt ; Tue, 6 Nov 2007 08:28:32 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 89B94277AE;
	Tue,  6 Nov 2007 08:28:32 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id D925156D22; Tue,  6 Nov 2007 08:28:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <635FFEC2-2489-443B-8425-DF2B58BE23C2@mac.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFz5CxQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63631>

Michael Cohen, Tue, Nov 06, 2007 02:41:56 +0100:
> On Nov 5, 2007, at 5:52 PM, Alex Riesen wrote:
>
>> Gerrit Pape, Mon, Nov 05, 2007 13:49:20 +0100:
>>> +	for (i = 0; i < 2; ++i) {
>>> +		snprintf(name, sizeof(name), "%s/%s", path, sub[i]);
>>> +		if ((dir = opendir(name)) == NULL) {
>>> +			error("cannot opendir %s (%s)", name, strerror(errno));
>>> +			return -1;
>>> +		}
>>
>> Why is missing "cur" (or "new", for that matter) a fatal error?
>> Why is it error at all? How about just ignoring the fact?
> In Maildir format, cur and new hold the mails. :P

So? Why *STOP* reading the mails if just one of the directories could
not be opened? IOW, I suggest:

+	for (i = 0; i < 2; ++i) {
+		snprintf(name, sizeof(name), "%s/%s", path, sub[i]);
+		dir = opendir(name);
+		if (!dir)
+			continue;
