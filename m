X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFC \ WISH] Add -o option to git-rev-list
Date: Mon, 11 Dec 2006 01:15:20 +0100
Message-ID: <e5bfff550612101615u5f588513n499e3b88ce14a6f6@mail.gmail.com>
References: <e5bfff550612100338ye2ca2a0u1c8f29bbc59c5431@mail.gmail.com>
	 <Pine.LNX.4.64.0612101009040.12500@woody.osdl.org>
	 <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
	 <Pine.LNX.4.64.0612101159530.12500@woody.osdl.org>
	 <Pine.LNX.4.64.0612101213520.12500@woody.osdl.org>
	 <e5bfff550612101405h507cc877k87491264d11b0aa8@mail.gmail.com>
	 <Pine.LNX.4.64.0612101410220.12500@woody.osdl.org>
	 <e5bfff550612101435o6bc938acmac28ad6adf0c8844@mail.gmail.com>
	 <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 00:15:35 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZmUZBzIoY8S2rCxQDtpcrjD3cZvsl6xKNpre1X7nvrWCHNHCItxkJapmX9wZTk+vqaPd5P4dAY4G5IFMWNbaDuh+xQ+skNNX5B3tZ/0MrTwoxHU61MWtOaPriEemvNgqLn1LovDhuRyEhcQJJwofgfhf0RlXME+sNklPyzUCUmI=
In-Reply-To: <Pine.LNX.4.64.0612101439540.12500@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33967>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtYpJ-0004CS-4I for gcvg-git@gmane.org; Mon, 11 Dec
 2006 01:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760455AbWLKAPW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 19:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762577AbWLKAPW
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 19:15:22 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:17375 "EHLO
 py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760473AbWLKAPV (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 19:15:21 -0500
Received: by py-out-1112.google.com with SMTP id a29so809757pyi for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 16:15:21 -0800 (PST)
Received: by 10.35.112.4 with SMTP id p4mr8463852pym.1165796120720; Sun, 10
 Dec 2006 16:15:20 -0800 (PST)
Received: by 10.35.93.11 with HTTP; Sun, 10 Dec 2006 16:15:20 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/10/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> looks about right.
>

Yes it's right. Thanks!

But it's still slow. Almost one second (985ms) to read the little qgit repo:

$ ./qgit HEAD
Found GNU source-highlight 2.5
count is <-1>
count is <60169>
count is <-1>
count is <60505>
count is <-1>
count is <61462>
count is <-1>
count is <61911>
count is <-1>
count is <61392>
count is <-1>
count is <61880>
count is <-1>
count is <62009>
count is <-1>
count is <62549>
count is <-1>
count is <21354>
count is <0>
$

As a compare the temporary file version needs a mere 105ms (1030 revs).

This is the code under test:

bool DataLoader::start(const QStringList& args, const QString& workDir) {

	QDir::setCurrent(workDir);
	_file = popen(args.join(" ").ascii(), "r");
	if (!_file)
		return false;

	fcntl(fileno(_file), F_SETFL, O_NONBLOCK);
	
	loadTime.start();
	guiUpdateTimer.start(10, true);
	return true;
}

void DataLoader::on_timeout() {

	if (canceling) {
		deleteLater();
		return;
	}

	int count;
	for (;;) {

		QByteArray* ba = new QByteArray(FILE_BLOCK_SIZE); // 64KB

		// this is the ONLY deep copy involved in the whole loading
		count = read(fileno(_file), ba->data(), ba->size());

		dbg(count); // DEBUG print

		if (count == 0) {
			/* All done, no more to read */
			delete ba;
			break;
		}
		if (count < 0) {
			delete ba;
			if (errno == EAGAIN)
				break;
			if (errno == EINTR)
				continue;

                       /* Anything else is fatal - report error */
                       dbg("Fatal error");
                       on_cancel();
                       deleteLater();
                       return;
		}
		if (count < (int)ba->size()) // very rare
			ba->resize(count);

		loadedBytes += count;
		fh->rowData.append(ba);
		parseSingleBuffer(*ba);
	}

	if (count == 0) {
		emit loaded(fh, loadedBytes, loadTime.elapsed(), true, "", "");
		pclose(_file);
		_file = NULL;
		deleteLater();
	} else
		guiUpdateTimer.start(100, true);
