From: David Turner <dturner@twopensource.com>
Subject: Freeing struct lock_file?
Date: Fri, 03 Apr 2015 17:45:15 -0400
Organization: Twitter
Message-ID: <1428097515.31333.2.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 23:45:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye9P2-00052b-Hl
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 23:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbbDCVpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 17:45:20 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34592 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbbDCVpT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 17:45:19 -0400
Received: by qgfi89 with SMTP id i89so17804211qgf.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 14:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=qgFYsZtXjjkIxG/I9GCvKxmBNxMj4yhTuFU8XCwnABA=;
        b=hfAXylFRxY+zrELZbcE9+c3TJ3elY21tHoKBoLE8JZ0ICNJzQq3zKOxkyii634vuW2
         BNSAx6qiIB9e1KJ8yzaZjI7rKkNaCELMQb7Agyjpz1oE3YObBaT98sdv65f7N4vDv1kW
         Zph3DPpzkX8UR2SW3FKgPRGz3CyHQQs2hAWvNZJdUT9p9KQkAMqqlQRfd4ikAk5u41QV
         pioJMTXlBNBYJGLa28uSufmY4M6OeM85JXM9vGkdG3GRq9t2veVf9SCMVY3YVpIzIWWC
         sx2w0cJrbhRjgwDBHVCj+Z2TKl56xT1HNwH/f9hk2wK/reqytojMwIbgv8i5QsO1zrDA
         uNpQ==
X-Gm-Message-State: ALoCoQkL9IXHLoJqErMHYUMR48w9e0XW0PDFGUlr5HGC5Mga6KYafYGgUtiTtbdE6m7TAYK0UV7/
X-Received: by 10.55.50.20 with SMTP id y20mr8106138qky.58.1428097518687;
        Fri, 03 Apr 2015 14:45:18 -0700 (PDT)
Received: from [172.18.24.49] ([8.25.196.26])
        by mx.google.com with ESMTPSA id n52sm6496121qge.39.2015.04.03.14.45.16
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2015 14:45:17 -0700 (PDT)
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266733>

Why is it impossible to free struct lock_files?  I understand that they
become part of a linked list, and that there's an atexit handler that
goes over that list.  But couldn't we just remove them from the linked
list and then free them?  Even if we couldn't free all lock_files, maybe
we could free some?  Anyway, just curious why that decision was made.
