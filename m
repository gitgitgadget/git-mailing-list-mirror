From: Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC] Identify where a Git config is defined
Date: Tue, 2 Feb 2016 10:27:06 +0100
Message-ID: <3226E251-73F9-4410-84DE-49C8FFAD92EB@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 10:28:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQXF0-0006Ji-0a
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 10:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbcBBJ1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 04:27:12 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36729 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbcBBJ1K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2016 04:27:10 -0500
Received: by mail-wm0-f49.google.com with SMTP id p63so108182188wmp.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 01:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=CSwyAaeGTUjO87jlLHkJpz2Xv5kb9T7dunB9D3r5h0k=;
        b=xzkk2MxHaeAuZoyVY+3eigli8oErOkCJaXqWJEnIBW12+Ma8GOKsg4I4PlGMQoh6LW
         Qr/f+PUtjJt+7e2p5+CfBkZlA67MvnIjMaeH3eMbM1sLl9C4wtAJUCYVov29S4A1HJNN
         RWiwnQSJZpiJhPSj7+2n1LWMPtZFYzrWl9Dq4kuWTrhRcStHWnMh6Pc6L0uXCJQenTF4
         MbTlWCxYBMKm/ULI0EtQLfqY3Pji0h10piKYw76Tk1PPcgej3IeAx+nda580frvUCfqG
         oTaeK4yds7klGU2YImV9vQSXN9Q5lujQywj5KmFhBrLdYLDvBErFfhBfZKY++L6d6VR7
         Y+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:content-transfer-encoding
         :subject:message-id:date:to:mime-version;
        bh=CSwyAaeGTUjO87jlLHkJpz2Xv5kb9T7dunB9D3r5h0k=;
        b=M4LXJlbYjzZLUvaRh4+UF0Xui1pnIYM5429+jhO2eOfjJYDWPTbLbHZ6lzNrlob8qO
         asRzpmIiB1N4NaBk5TAJm+d3Q1CxChA3hwjLIdfUY+tAqOTjuok8RAdGBVs6UFT1I84z
         yhK53sL+XjoQLhkQtwd9kGdDkQAWeALRdF3GxqjURIEFcTjJhRYH7IsEGQQ5YqqOYx2r
         b2Ll7GDtJcAOxwinrn78/j2wAd5cmvBtA/4m4ijSiXI3HeDgJbp7swfSBKgR1R6DYF/E
         eGdIKMEYvQwKHGv9fgAQ1hFbLDQMV7BW/tn0DvDNwplM3/SePKIjjn85mn6gXscBY/Pu
         Yotw==
X-Gm-Message-State: AG10YOSH/aJfeWT9YB7XlPB1un9OsMTF6Why2XI9AuJLwiR/VqtNPJlwqc75ci5VoYyeXg==
X-Received: by 10.194.9.200 with SMTP id c8mr10218174wjb.63.1454405228755;
        Tue, 02 Feb 2016 01:27:08 -0800 (PST)
Received: from slxbook3.fritz.box (p508BAB78.dip0.t-ipconnect.de. [80.139.171.120])
        by smtp.gmail.com with ESMTPSA id u191sm15491765wmd.4.2016.02.02.01.27.07
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Feb 2016 01:27:08 -0800 (PST)
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285246>

Hi,

Using "git config --list" shows me all configs but sometimes I have a hard time to figure out where a certain config is defined. This is especially true on Windows as I found the system config in various places. I wonder if other people would find it useful to enable something like "git config --list --print-source" where every config value is printed with the file where it originates from.

If I read the source correctly this would mean I would need to change "config_fn_t" to pass not only key and value but also the config source file in addition. Since "config_fn_t" is used in many places this would be a big change that probably is not worth the effort?!

Alternatively I was thinking about "git config --print-source-files" to print all config files that Git would parse. This would already help to find the configs and would probably be a smaller change.

Thoughts?

Thanks,
Lars