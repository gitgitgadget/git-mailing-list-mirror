From: Leonardo <leobasilio@gmail.com>
Subject: Merging branches with smudge filter
Date: Thu, 4 Feb 2016 21:10:37 -0200
Message-ID: <CACqLfMk_qDhbXUjWLtBLP4o=CeKEgaWAm881h03fneuiRO-v2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 00:12:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRT4Q-00037X-TX
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 00:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757816AbcBDXK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 18:10:59 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:34565 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757412AbcBDXK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 18:10:57 -0500
Received: by mail-io0-f171.google.com with SMTP id 9so111039136iom.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 15:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=0DN2gISsAwR3TfEzPUaLnRw3uTdRn7lgzSrfdJUrdYk=;
        b=vQqRII6oecn7Z+JKa9yWz5+9eM2PoGXKJiJk0ApWLL9sPBagiLTab8cGrx4dsGpx4/
         Z+A2Mk6aBk7OoXxcp0nyPooD7CmDVjMAq5bfvRu4EvC4tr3IEhfm+ND/6zein7bZgaW5
         x06stZwMIhi9IhHEpGFcEkQdNuqxuX3vh4IspoZC2yC4jGGfCbVm/fUvtjA/KJPuQ1aE
         kXYUt3mb5y1GEw25h/tSIpijzg4gH3xGFRcBQ3gdanv9Q1ZlVweR8k7gBm3/3I8NIQFP
         ByRveLubICliZATL9lop2VNPOhxFlm8CjdBvgTOCVvts9xPEQpqlF43E4ltcD1S5auhI
         fk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=0DN2gISsAwR3TfEzPUaLnRw3uTdRn7lgzSrfdJUrdYk=;
        b=bhfO/uSGyOQqv7523gNviSRFGckA+xZSCH9LiFF6cAxWNIC/Tphxc2o+X/w1p2oMu4
         /Z2YcbtjyG+AM6RcYxVvMu8dIPVFJwPTJUcxUsKoLaxfuRrzMjC24CPgyyPQMrkUwjAw
         vVqa5d+oEDQhw5771kcLHJRlHHVjYcrqks4+IOOSAlrANVsotPuJFzPr2aySAB9aOe2/
         obeckeOY5tVQdVPoTHN7CrIyG/Q4UwJPypqSdj4zYTvY2REY4QQeyS/+YygDIZOPl899
         ePZtIDRQWiCuyZyc7MRo5g5PkzH+s4cniYBTCIGt41ZSPXBWlNq03D4Szdq7bOsgkRf0
         08mA==
X-Gm-Message-State: AG10YOQxMLR/NHAhJuppTKV+TDeP2wyDnRD9C+Ey5k78qOa6XbTRW6AB9YDR1II0mwf1RFCSKXT0cOz15T9W6Q==
X-Received: by 10.107.34.16 with SMTP id i16mr13686880ioi.22.1454627456642;
 Thu, 04 Feb 2016 15:10:56 -0800 (PST)
Received: by 10.107.35.9 with HTTP; Thu, 4 Feb 2016 15:10:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285515>

Hi, everybody. I'm new to git and I'd like to keep track of some codes
we have here in our company. They have some sensitive information I
would like to keep private. After some googling, I found some
solutions that encrypt/decrypt the files using filters as they're
committed/checked out. I've been using this approach and it suits my
needs. Now I need to merge two branches, but the process is failing
for two files in particular. First of all, here's my config file:

[filter "openssl"]
    clean = openssl enc -aes-256-cbc -a -nosalt -pass pass:password
    smudge = openssl enc -d -aes-256-cbc -a -nosalt -pass pass:password
    required

For these two files I mentioned, decryption fails. Then I did this:

    smudge = openssl enc -d -aes-256-cbc -a -nosalt -pass
pass:password || tee -a /out.txt

Based on the output, it seems like the input data is corrupted, but I
don't get it. These files are regular source code like any other file.
I can also check out both branches individually, so I'm assuming the
stored blob is fine. Every other file is perfectly merged. What should
I do?

Thank you.
