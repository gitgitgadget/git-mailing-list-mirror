From: "Caio Marcelo" <cmarcelo@gmail.com>
Subject: Binary files in format-patch
Date: Mon, 5 May 2008 19:55:06 -0300
Message-ID: <d280d7f10805051555x67bd7e87o999a2c9e19663b92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 00:55:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt9bB-0008Oa-TM
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 00:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbYEEWzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 18:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbYEEWzI
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 18:55:08 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:33943 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbYEEWzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 18:55:07 -0400
Received: by mu-out-0910.google.com with SMTP id w8so5024mue.1
        for <git@vger.kernel.org>; Mon, 05 May 2008 15:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=IzMDnVm57ZVYpiI0hkNVSxp6WJ2+kjmlPz1u67wA880=;
        b=Apql5CfU3YaWKeVasxKEr3PfMXEpxWzP73AhyRcp/f35LUFq3NYngfPHSa3fxcBADDHSDLyyqSLblVU20e6Cbz0OXKr7koqv3Grb9pAbYr2xc+V/dkWYZ5OiiBxy2Lrfjx3fNg7itjXeOV9AYhFU2H2VBwmiGGeD3Pjpen29DQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=g0jVli71I2JnRmcHhlKy9dZTMuwUmZY6FKdoIN8kDyGHVGuYKiDxdtthhW2jWZzissQXGqaFsNUOxE7vw/DI5soOUciCbIM2JSKQIdC1S0YUgkDMy2Y3P7gHYlfwqKOREfrUUf7NQJzOb7NOk9UPQ66SkdVlDl30T0m7vR7SPYQ=
Received: by 10.78.129.16 with SMTP id b16mr16427hud.116.1210028106112;
        Mon, 05 May 2008 15:55:06 -0700 (PDT)
Received: by 10.78.140.8 with HTTP; Mon, 5 May 2008 15:55:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81312>

Hello,

I'm using "git format-patch" to generate messages for a code review
mailing list. It work fine except when we have binary files involved.
Their contents are not relevant for us, and doesn't help much in a
mailing list. Taking a peek at the code I've found out this:

In commit e47f306d4bf964def1a0b29e8f7cea419471dffd (short name: "git
format-patch: make --binary on by default"), we add a new restriction
on the possible options to format-patch: if you don't specify --text,
it enables --binary. But looking at today's code, we have a path that
is never taken for format-patch, in function builtin_diff (diff.c), at
lines 1423 to 1433. The fprintf doesn't ever happen, because if it's
TEXT, it dumps the contents verbatim, if it's BINARY, it encodes (to
some baseXX) the files/diff.

Wouldn't be nice to allow this code path to happen via some
--omit-binary / --no-binary option to be checked in cmd_format_patch?
(I could provide a patch for this, if you think it's a good idea).

Or should I try to solve my problem by other means (post-processing
the patches, building my own with git-diff)?


Cheers,
  Caio Marcelo
