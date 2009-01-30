From: Reece Dunn <msclrhd@googlemail.com>
Subject: [RFC] Line diff fragments, custom colour markers and word change 
	highlighting
Date: Fri, 30 Jan 2009 20:44:26 +0000
Message-ID: <3f4fd2640901301244s34d94e0fka00ce2eb6f6bef48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 21:47:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT0Fc-0007O3-9n
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 21:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbZA3Uo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 15:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753558AbZA3Uo2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 15:44:28 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:24747 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbZA3Uo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 15:44:27 -0500
Received: by rv-out-0506.google.com with SMTP id k40so608765rvb.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 12:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=i0AT4JvNmcfbv8rVzdIpc6INnV01dVp0NF7XYbECv9A=;
        b=NfZasxa/rr7Sl1a+1YWLdroicON2YGE+MRt09LlepXClNIb6Qtxst90ezNtX52kPxY
         GEFrBr6Nkv7QnwtDZXIEleTKfaKT6xe6Oo7mSRxHGz3oHQgaRpTQMN/Yk/KrWOfawOIJ
         D5+1zxwnPoNId2bq1DUS8wSZWmKCRvZ9WUzaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=HGay8M3ES325c571D8TVQkUSBKfW3tmn5De09HV4OFsQlAre20CoLWTBF3ZsCw2uJ6
         zL2z5WBBTlEBHkNzleepIs9zKhmRmNbG154FVOLwhkzSqSGS4MlgBgo2PXgrVZwXFU9h
         m4EzmSSVZVjb+uBRrsa5J/dqJGi8BiLQ7Us2g=
Received: by 10.142.125.9 with SMTP id x9mr641523wfc.236.1233348266539; Fri, 
	30 Jan 2009 12:44:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107873>

Hi,

I am using git to track various online stories and use it to keep a
history of any changes I make as I proofread them. The idea is that I
can then send this to the author for approval, so they can update the
stories their side and post updates.

At the moment, I am manually editing the output of git diff to produce
the desired output. I intend on modifying git to get it to produce the
output in a format that I am interested in so that I don't have to
edit it by hand.

The purpose of this RFC is to outline the changes I intend to make
(while still providing the existing behaviour) and see if it is useful
to go into the main git repository once I have implemented it:

(1) Line diff fragments

Taking the Lorum ipsum text as an example, if there is a typo in one
of the paragraphs then `git diff` will render the whole paragraph.
This is useful for machine processing, but not necessarily useful for
human readers. I have been cutting out everything but the paragraph
where the error is located, but a limit to X characters or word blocks
would also work. For example, showing:

$ git diff -U0 --fragment
- ... consectetur adipiscing elot. Proin interdum leo quis elit. ...
+ ... consectetur adipiscing elit. Proin interdum leo quis elit. ...

(2) Word change highlighting

Provide an option to allow the colour format to highlight just the
words that have changed and not the whole line. There have already
been some discussions on this ("git diff colorization idea"). So:

$ git diff -U0 --fragment --color-words
- ... consectetur adipiscing <red>elot</red>. Proin interdum leo quis elit. ...
+ ... consectetur adipiscing <green>elit</green>. Proin interdum leo
quis elit. ...

(3) Custom coloured diff markers

When performing a diff, you can get it to highlight the output of a
diff using terminal colour markers that will be rendered correctly if
your terminal supports processing them. This is great if you are
viewing the diff from a terminal, but if you are pasting it to another
media (forum, web page, etc) the colour information is lost.

It would be useful here to change the strings being written out to
denote colour, allowing you to generate HTML/CSS or forum/wiki markup
depending on context.

This could also help the git-web and git-gui tools that colour diff content.

I am not sure how this would work via command-line. If the output was
in a form that was easy to pipe through sed I would be happy. For
example:

$ git diff -U0 --fragment --color-words --color-markers
- ... consectetur adipiscing <red>elot</red>. Proin interdum leo quis elit. ...
+ ... consectetur adipiscing <green>elit</green>. Proin interdum leo
quis elit. ...

where <red> and the like are actually outputted and not there to
represent the terminal colour marker instruction character sequences.

Thoughts? Comments?

- Reece
