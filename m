From: =?UTF-8?B?SHJ2b2plIE5pa8WhacSH?= <hniksic@gmail.com>
Subject: Make "terminator behavior" the default with --pretty=format: ?
Date: Tue, 22 Feb 2011 16:43:56 +0100
Message-ID: <AANLkTimFYsG3x0uGX32Ozo6C_shHd4k8jnXNhYmy7Q80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 22 16:44:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PruPI-00037O-Ve
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 16:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab1BVPn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 10:43:59 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39969 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab1BVPn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 10:43:57 -0500
Received: by ywj3 with SMTP id 3so1292297ywj.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 07:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=096rsbG2jvsq5E5MEJ3XQAvD8kROJvvN2nvStuvBorQ=;
        b=fXDl1uIRJ6tDUWnEQ9IHmgmKcMSJi6dyc+575kGPoYSOMhyymUqxCAyziXYSWk88X+
         dzfE3RbgtIdEjpwqYQgm3dg41QCHP35gy3oldRDqqDurRhDTT1+iqyvfvlm62m4akaxb
         e/u6t4caOc+ZImaPRREIG1m3WLyKXbxaUKCG4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=UDqgDUc8eCdBlpkDNUN75ECEoHVxyCt/HHcfo5YIJw4hiEy6r15/pyvfx9tNlienD2
         AZmr9CfHfDDaFS9hdWjdBaP3OPGPckayDj/Ev3z88UkO8paPCCg8rqT+d7J+Py/orrWJ
         gL695WtAy4nm+j28w8lyWvaKNXnknPdUJMMZQ=
Received: by 10.91.196.33 with SMTP id y33mr3708066agp.137.1298389436846; Tue,
 22 Feb 2011 07:43:56 -0800 (PST)
Received: by 10.90.25.6 with HTTP; Tue, 22 Feb 2011 07:43:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167557>

Is there a reason, other than backward compatibility, for
"--prety=format:" to have separator rather than terminator semantics?

I got bitten by this badly today, because I was processing the output
of git log --pretty=format:... through sh, like this:

    git log --pretty=format:"%H %an" $old..$new | (
        while read commit author; do
           ... some processing ...
        done
    )

It turns out that the sh (which includes bash, dash, and zsh) "read"
built-in doesn't process lines that don't end in newline. The effect
was that the last line of output was silently ignored. It took some
hours to track down.

sh is not the only tool with this problem; many traditional Unix tools
don't process lines that don't end with newlines, and some require
special exceptions and kludges (think diff). Because of this I believe
"format:" should be changed to do terminator semantics, and tformat
deprecated. If this is not feasible, then the documentation should
recommend "tformat:", and only mention "format" as an afterthought,
rather than the other way around.
