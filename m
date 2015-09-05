From: Pedro Rodrigues <prodrigues1990@gmail.com>
Subject: Bug? push --recurse-submodules=on-demandd not really recursive
Date: Sat, 05 Sep 2015 09:31:03 +0100
Message-ID: <1441441863.2246.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 10:31:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY8st-0000Cp-UP
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 10:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbbIEIbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 04:31:20 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35532 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830AbbIEIbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 04:31:17 -0400
Received: by pacfv12 with SMTP id fv12so47190711pac.2
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 01:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:subject:to:message-id:mime-version:content-type;
        bh=T52OSQ2cEXZAHR2BYjvtN4zxTHJxF8F7f8rBgEUpU0Y=;
        b=Kz1RPb3qvsF3dZFqtrApfrz/qiXi1IxzanWm3m3i0hilc0+KHK6T5vI+8+QGK/Tx7E
         igIuVZlw/6DbAHDZjTZrfppbbacRyG7hjtmkkGuCkvLKvuNDVN0RWoYqTmHgnPk1DWvu
         G1TVkps+3SrQKXSgRiwnEA6trEWd6qsK3Yc2QVgUjbyl0boza07IhBxpqryrji0dVcNu
         SlROwjIaQxX5khC33WUaJj1P4ny+8wz3j5wUFmypn1ABoX0Qmf94LGMTMZT/U4RTZrWa
         fCM/u1jvNlKKG1E/+ch1EqWhGSRAd/z02RCXmQP5Wuxsjp++gt+lQuSpZRbY9DJZOfd4
         lqqw==
X-Received: by 10.68.109.34 with SMTP id hp2mr18238278pbb.52.1441441877003;
        Sat, 05 Sep 2015 01:31:17 -0700 (PDT)
Received: from [192.168.0.16] ([197.148.37.177])
        by smtp.gmail.com with ESMTPSA id sb2sm5015169pbc.32.2015.09.05.01.31.12
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 05 Sep 2015 01:31:16 -0700 (PDT)
X-Mailer: geary/0.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277363>

Yesterday I was discussing this in on G+, which lead me to conclude 
this is actually a bug (or, at least, a very good improvement).

When you run push --recurse-submodules=on-demand, according to the push 
manpage you would expect any submodule commit missing on it's default 
remote to be pushed aswell. But this only works for the submodules of 
the repo you run it in, it does not work in nested submodules (hence 
not being recursive at all).

I could (with my very little understanding of C) confirm this in the 
source code, and the boils down to the function push_submodule on file 
transport.c explicitly calling push without any params, where I would 
expect it to call with --recurse-submodules=on-demand when done so on 
the parent repo (and then it will actually be trully recursive).

Any thoughts?
