From: Jacob Kaplan-Moss <jacob@jacobian.org>
Subject: Re: git-stash fails on OSX 10.5
Date: Mon, 13 Apr 2009 13:13:05 -0500
Message-ID: <be4ebbe10904131113q5b221fe9kf7e0a0fe3bb7fdc6@mail.gmail.com>
References: <be4ebbe10904100944p6ec2c0dao8607fcff75d2754e@mail.gmail.com> 
	<7vy6u8whbp.fsf@gitster.siamese.dyndns.org> <be4ebbe10904101114w33c807d1je19b0c949e9a2009@mail.gmail.com> 
	<76718490904131057k2801a62bn14825b055b345dfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 20:16:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtQgO-0003BM-Av
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 20:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752229AbZDMSNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 14:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbZDMSNY
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 14:13:24 -0400
Received: from mail-gx0-f160.google.com ([209.85.217.160]:47338 "EHLO
	mail-gx0-f160.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbZDMSNX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 14:13:23 -0400
Received: by gxk4 with SMTP id 4so4730323gxk.13
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=Ts37WPhZ1T5oxsRGzDY/At9L37K2pTXG/3TPGZ9O99s=;
        b=qJXMandKVmx9sM7NJdoxF7sdT7qj/MCGcRLPrbb2Sc0eeAWH3WqiPVH5m+7gVYKYMQ
         LfC3nR4+1+B/RyMbsnXNRQLUBOiYkHhTtcz+0RaN7asJEtwCjDnX2PSfu2DY40iPaViy
         KNHTb4Jpj4UTLhOLK/gxqyxp/eHUAbf2NgPW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=f38sMiAnkCCRFIMrszj6JKiX/MAxCZMMg/k1SfyveGq7zMex/QlJBcVzjvyyaWiuCX
         XKkaor0y/rQgphJAJ0jItW1xMfex1zk+PEPNUtxMKqaIh2BKSwLx3gVWPadywxdJTGeI
         cyvZFQJ0dsWLLsPkaXbJqr50AGcTsB9mQRteg=
Received: by 10.90.66.14 with SMTP id o14mr2478983aga.43.1239646400744; Mon, 
	13 Apr 2009 11:13:20 -0700 (PDT)
In-Reply-To: <76718490904131057k2801a62bn14825b055b345dfe@mail.gmail.com>
X-Google-Sender-Auth: 21161f1821a5e225
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116458>

Hey Jay --

Thanks for the questions; they helped me figure out a bit more:

On Mon, Apr 13, 2009 at 12:57 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> 3) Anything unusual for OS X? e.g., Are you using FileVault? Are you
> using a filesystem other than case-insensitive HFS+? Is your cp
> command something other than /bin/cp?

The filesystem is case-*sensitive* HFS+:

$ diskutil info disk0s2
...
   File System:              Case-sensitive Journaled HFS+

... and cp is GNU cp, not Apple's:

$ which cp
/usr/local/bin/cp

Looks like if I use Apple's cp then stash works again:

$ mv /usr/local/bin/cp /usr/local/bin/cp~
$ which cp
/bin/cp
$ git stash
Saved working directory and index state "WIP on master: 504b9bd
Updated README."HEAD is now at 504b9bd Updated README.
(To restore them type "git stash apply")

So clearly there's some interaction between git-stash,
case-sensitivity, and GNU cp. Given that GNU cp works correctly when I
do it by hand (i.e. "cp -v /Users/jacob/Projects/uri/.git/index /tmp/"
works), I suspect that git-stash is getting the case wrong somewhere
and Apple's cp is automatically correcting for that error.

That's my theory, anyway; my bash-fu isn't that good, so I've not been
able to figure out a way to patch git-stash to work around the
problem. I've got a strange setup, I guess, so I understand if this is
a "just don't do that" kind of situation.

Thanks!

Jacob
