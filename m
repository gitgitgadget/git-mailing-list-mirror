From: Paul Beckingham <paul@beckingham.net>
Subject: Bug: partially staged file is committed in whole, if there is another staged file
Date: Sun, 17 Aug 2014 13:05:46 -0400
Message-ID: <96FA86FB-D017-470F-899F-EA0F6F28C1E4@beckingham.net>
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1972.3\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 17 19:05:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJ3ty-00042g-Pf
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 19:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbaHQRFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 13:05:50 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:56595 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbaHQRFt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Aug 2014 13:05:49 -0400
Received: by mail-qa0-f42.google.com with SMTP id j15so3643201qaq.15
        for <git@vger.kernel.org>; Sun, 17 Aug 2014 10:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:content-transfer-encoding
         :subject:message-id:date:to:mime-version;
        bh=1vmAg5fjC+W2+JNBwC6yWVPg+nq1ylfybws2ba6jeNs=;
        b=VHqiwBpDHOQCbmCTOu4Qw+d7W4143KxiVi6LTDKeZbhZ8EKpC7RCiRhI/TcMksd1gz
         YgzmP0VpdOcuZO1xc6QK74tdgdx+RBR4EBdoQiU+Bdum9/V6XHt9x5pT315rSSpLpLW5
         P3aVC0s0Hd1wZh1/oUT0kgY89QIG0TwMJcJzMQGRPhrYEbgwMu995KHPBhD0q72D7F+7
         WiFiq7s4RuOF1aKSOdJ9UM+RQ3O002sIIofFDqx9cKreYk/5b9vm5XFls5laup5VQdCE
         3rYw3d/Fv4lTBlRFzKQKZic6tczs2qmjUYPF4jKncHTZs1bVpoV+daGjVC8qdY2akiur
         ZxhA==
X-Gm-Message-State: ALoCoQmlhZjD+VLo8k7WdZXyAovD5U6bwhDRObbKdsDvS0Jlct4wevs4ud4czMliCu3PkU6b5IYE
X-Received: by 10.224.89.10 with SMTP id c10mr49308663qam.51.1408295148459;
        Sun, 17 Aug 2014 10:05:48 -0700 (PDT)
Received: from [192.168.1.39] (c-98-217-152-192.hsd1.ma.comcast.net. [98.217.152.192])
        by mx.google.com with ESMTPSA id u6sm25319989qap.24.2014.08.17.10.05.47
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Aug 2014 10:05:47 -0700 (PDT)
X-Mailer: Apple Mail (2.1972.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255369>

If I have two modified files, and file1 is staged (git add file1), and file2 is partially staged (git add -p file2), and then try to commit only the partially staged file2, git commits *all* changes to file2, not just the staged part.

There is no bug without file1 also being staged.

Here is a transcript illustrating the problem:

$ uname -v
Darwin Kernel Version 14.0.0: Tue Jul 29 16:22:25 PDT 2014; root:xnu-2782.1.62~4/RELEASE_X86_64

$ git version
git version 2.1.0

$ git status -sb
## master
M  file1
MM file2
$ git commit file2 -m "adding patch"
[master 066a6e2] adding patch
 1 file changed, 2 insertions(+)

$ git status -sb
## master
M  file1
$


Regards,
Paul