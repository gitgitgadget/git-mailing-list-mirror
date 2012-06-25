From: Jay Soffian <jaysoffian@gmail.com>
Subject: git fast-export bug when using rename detection and paths contain spaces
Date: Mon, 25 Jun 2012 15:31:12 -0400
Message-ID: <CAG+J_DzGyog-pZrVzuxom0HfdBnf0MvbCMdNYNdaC=dFA31mRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 25 21:31:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjF0H-00066K-Sv
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 21:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab2FYTbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 15:31:13 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43621 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088Ab2FYTbN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 15:31:13 -0400
Received: by yenl2 with SMTP id l2so3152609yen.19
        for <git@vger.kernel.org>; Mon, 25 Jun 2012 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=j/+OXcRlaxqtYMUm96uNeoSH0GtXQ6g8wcxJjpgy518=;
        b=Xqsj2R6zAU6mYTltoshcVS1MAxIV0s/3DIbgcevTQHU6EFo3CDgmiPquFPYCVXfKvF
         UIMhjFCPUT9qCGBhQzfzcfzf4NDFhUKPbGDFhLlrKvtYHXJHCdigm64CrwvART7VzRCE
         5zp+MD0/gtmtdMUBRmt6ojWKUC0ftDj6USLZkkcmDbjBw+eAbF7pajeXovOEVaB0oUAA
         kJ43i5AUyjD7YhsYWOrniZGrOdJSy7sTwwVeownGl7eW86+6mn5xe3++IUreM8+aa6eg
         ZVceiCA6ojHnebYG0fj3Zxg3rD1TGI+95jR4CZ23VlKKqBHSGVdp7SS8B5WAkcvPQHQQ
         eh1g==
Received: by 10.60.2.34 with SMTP id 2mr13365156oer.71.1340652672467; Mon, 25
 Jun 2012 12:31:12 -0700 (PDT)
Received: by 10.60.140.168 with HTTP; Mon, 25 Jun 2012 12:31:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200593>

Repro:

git init temp-repo && cd temp-repo &&
echo foo > "foo file" && git add "foo file" && git commit -m foo &&
git mv "foo file" "bar file" && git commit -m "rename foo to bar" &&
git fast-export -C -M HEAD | grep ^R

Outputs:

  R foo file bar file

It should output:

  R "foo file" "bar file"

This was allegedly fixed by 6280dfdc3b (fast-export: quote paths in
output, 2011-08-05). It seems that that commit expects quote_c_style
to output surrounded quotes when the path contains spaces, but both
empirically and from my quick look at quote_c_style, it doesn't seem
that the function does that.

Sadly, I don't have time to submit a fix ATM.

j.
