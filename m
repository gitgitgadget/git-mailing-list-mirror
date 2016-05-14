From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Git log three-dot notation: include merge base
Date: Sat, 14 May 2016 18:09:21 -0500
Message-ID: <CAHd499A_AN0U7gj8Yp0pBGGZ6deNrDJ4F4npAKy6a2U0+uTsxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 15 01:11:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1ii3-0007cH-NK
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 01:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbcENXJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 19:09:23 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35133 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbcENXJW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 19:09:22 -0400
Received: by mail-vk0-f44.google.com with SMTP id f66so176454962vkh.2
        for <git@vger.kernel.org>; Sat, 14 May 2016 16:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to;
        bh=B5Mn8g7Q7R1Zi4df1yJemvNiRmMhHHDCbLX1h0SLExw=;
        b=QG9kNRw8DFQNhcgddvGSTx5zsdUIS8UcKNtj4CLoTKVlQVMHeazs95tAGyUD/I5ljw
         0kXpfmIP2dSrwZyfJMaRZZyvphZDx8oNpZZJ0R9WDUw9I85x6FF6W4eQFARIDuVbQoyw
         CCRRvp2NnQhq4kHVKCocmyYxd1WBTtuae/W3xcgM/jTAHBUmsIWbDIm2Pm2rBkCsCKHu
         giA+EdmkNQR9t4F+Eag8xLrIn8uLWtdHvsU699GFxVdrbzdGEqfKd8Wns4MBRdFabJ41
         FECLfWTb9mKraSPsxu8ufPZ4PLNxRkE9ZpoPeVy63MDQlbpUGNIWGuQONzfuA7AMV+aA
         rbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:date:message-id:subject:from
         :to;
        bh=B5Mn8g7Q7R1Zi4df1yJemvNiRmMhHHDCbLX1h0SLExw=;
        b=C5tk6gGvBqPwrAif2QDoOv6lPfeB3jqEWbPt9qIY84GUbOelbOCXsRPxv1fZ5/u0bS
         4gd9tEl33bOCPLbexynDgQLmORz28wMTRE8SIX8dXC3iMG/Hg6//Bmk06cIlrvtc7J5Y
         sJjiHNsi2V4gaUog/Sp2ZURt7vyaYfVb8bnfKJQyK7MrfDugTM7yGt4atnrKPa5NHdhC
         5CG3Dog1bVFKFHnaEGTXBI1lsk/X5ntv48uad3fCZpUgh9LgwZJtTPxfD+XzSCim7B3L
         akYq3ejIsEhJ/uhELZFUk7Ro6KmCKsb3mt8JbOgLB/UrUOG6T47tO408MBcgf3uhVF/Z
         CBHQ==
X-Gm-Message-State: AOPr4FVQOS73ZqSccne5Z9Wf3BxACzbvZ6fNsXr/ZmW6KyyE0v7ODJ6f/G7h0fmrPDjAR1DhOyoqZXIfTQRapQ==
X-Received: by 10.31.74.69 with SMTP id x66mr11352100vka.145.1463267361737;
 Sat, 14 May 2016 16:09:21 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.159.34.134 with HTTP; Sat, 14 May 2016 16:09:21 -0700 (PDT)
X-Google-Sender-Auth: j8RW-Tm2j80uzqWRPfJJ---Q4qc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294629>

If you consider a simple case where I run the following command:

$ git log --oneline --graph --decorate A...B

Where A and B are both branches with a single merge base and a series
of commits on each branch. Very simple example with no loops or crazy
ancestry. Below is an example repo I set up, where I show the whole
repository log graph:

$ git log --oneline --decorate --graph --all
* eb28ae4 (HEAD -> B) Commit 6
* 7173fa1 Commit 5
* b5fe27b Commit 4
| * 37a8ca8 (A) Commit 3
| * 72745a7 Commit 2
|/
* ffc8040 Commit 1

Using A...B notation, I get this:

$ git log --oneline --decorate --graph A...B
* eb28ae4 (HEAD -> B) Commit 6
* 7173fa1 Commit 5
* b5fe27b Commit 4
* 37a8ca8 (A) Commit 3
* 72745a7 Commit 2

The graph no longer makes any sense, and isn't helpful to me at all.
This is because the merge base commit isn't shown. I understand this
is "by-design", but is there a way to include it? It's necessary to
have it, for this graph to make sense.
