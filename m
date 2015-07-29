From: Dave Borowitz <dborowitz@google.com>
Subject: Bug? git config and --unset are not inverses
Date: Wed, 29 Jul 2015 11:59:40 -0700
Message-ID: <CAD0k6qR0J0ks2mL9TTd4wD7qrzKwadFGC=ecJRCsTcSS0ioo_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 29 21:00:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKWaI-0000xD-5n
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 21:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbbG2TAC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 15:00:02 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35965 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbG2TAA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2015 15:00:00 -0400
Received: by ioeg141 with SMTP id g141so31262363ioe.3
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 12:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=LG4WW2xLC9FWUewoj2mtsH92KZ/2CL5d1QkDWteH3sM=;
        b=TtVdsepFgxUhtJttQZhR519s/oQkx1iXcKyOOd12YnRIDOQWtMA1y0WB5qb1SZyvKA
         WCtXsEi9Q0QRp7Q+9pj1PX1K7jc+YVPSVmYP8641p5y0G9pHluwPloyLT+213ES6lpWZ
         46b+k7dmvE0xkyRgn1jklw4CmhFv4pBH+uLK5zOb0bhiHqWNK+2A27txp+ELOhMOYebd
         03/av0wS9+us6vrysIT4gCiFWWWTX/oor+7WTi8aTmEGo/yAx66p3JgoWIE3NuesF5tP
         DnnGl0BsZa0v3/85v6DzkcT6fjGXNaKZDb28KgelvA304IDsKyPfHuRhviZyHzfdaU8g
         UQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=LG4WW2xLC9FWUewoj2mtsH92KZ/2CL5d1QkDWteH3sM=;
        b=E00SVy0Xn4H7D2VkJuk6xeAYXmrhKjWpFUAOnldqG1u7IdLnEIbdPazORbYD2O3p6O
         Lo7CP5kenjG+ARMIzj0nKF3E1OPlZ1gNUbcUlQTxUdc4WC6SJ/SweiBByEALjwtb8UPm
         Y80Dmat0Bxts/pB8juyNc4UI1xxGtmOWtyUsvIQwACpG+2WRTIZTJV8F3MbRsz4+QILq
         KsapfBTt8VJ8kRWCgBUMC74VmkvNwn9oPmbLHyda0H+77Z6135aIx3OLsRO1JX6lJNN2
         DoBdS+i3VzDL4ZkuBa0Z6Rv91Z8RD35Ee0dLCLYmPBIl7LPbUXHqJIKWhFCXbQm/0Mzi
         Nv6A==
X-Gm-Message-State: ALoCoQkMhAAxyZVDlCLHx5XWI0VQ2gGZjqw0HjVyS1Yz45Vkypj+DBcGeW7xd01DMHpfvPlkkL5U
X-Received: by 10.107.134.161 with SMTP id q33mr4397275ioi.184.1438196400130;
 Wed, 29 Jul 2015 12:00:00 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Wed, 29 Jul 2015 11:59:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274937>

It looks like git config --unset may leave an orphaned section, but a
subsequent set adds a new section:

$ git config --file=myconfig section.foo true
$ git config --file=myconfig --unset section.foo
$ cat myconfig
[section]
$ git config --file=myconfig section.foo true
$ cat myconfig
[section]
[section]
       foo = true
$ git --version
git version 2.5.0.rc2.392.g76e840b
