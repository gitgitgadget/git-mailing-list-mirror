From: Norio Nomura <norio.nomura@gmail.com>
Subject: [BUG] `git submodule update --init --recursive` stores gitdir in full path into `.git` of nested submodules
Date: Wed, 30 Mar 2016 18:03:25 +0900
Message-ID: <F89ED33B-E33D-4693-8559-4255727B78B8@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:04:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alC2P-0001Jy-T1
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758777AbcC3JDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:03:36 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33599 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777AbcC3JDf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2016 05:03:35 -0400
Received: by mail-pf0-f175.google.com with SMTP id 4so37281193pfd.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:message-id:date:to
         :mime-version;
        bh=9qgUd3CjOONwQKyGUgntFuLiZW5NVf49bPPfigwqD0I=;
        b=VEk7LeHVOuwHD2gNwhKDKrexCgmafYGC1D8AkYDqsvmlUic0aNmnz+VYHmHgaK7vrh
         D+bp0gQoAi2lrgDBCuOv1sjNCx5XKRbOIeeHP5FoQQ+mfe16D8rT2pIlifnLWNBGUs05
         eQ55imtl2FWWZOMj1aJhIjYve5zRN9hPHJe5b98ZYc1HZA9NT39iKj7/6rzvM6aWhuk9
         370cSh1rPPFN8kOGlcmmfSbOLYHa3at2qxLhtiO5D3E+65DGyaNdHAzULPjDH6qOhJ3d
         yht31XrUe/TNxSNFymY6k5Rq6pKpBn5a+a+mA4LzBItbYEfbG6vJBD4sNggw/AvuUaTp
         OPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=9qgUd3CjOONwQKyGUgntFuLiZW5NVf49bPPfigwqD0I=;
        b=WjSe5b4nQoJkFTslHt2LCEOfbTfTPO+v7MW0qYkpIJ1CfEFwhhw1FSncswdkMF8TA/
         zHGOa6n4OIyB8kNB7JWOQiUCjqiSOpiPDt9St82I46Um1nQQC1WAu+L5A7AhViUXlLwn
         91gGwwXOZTC/msGsaqpEyFDSAh0xNdmDgcgIlMvCZ/LsFk6yhgEgekYbYUCKYFDUJ8/U
         /vHqHBwpnbixp/KlTQUSBpMXLV95a8s1y1UxORDlwBhRnnsVdqz1vVqAGSmZqIbFGuLf
         BQqcDpJjcitP16j2HGq/oQ7JuZE2+V36c1txNCt1DDMeJPNxNw7BTNqiWeIkO9+E8iqp
         q6/g==
X-Gm-Message-State: AD7BkJKWuR+PTJWCK/l1NoWudyUF5GxDu0DgrqkFDGFY1Ulu2x2HNYqsQjnIAg4HbtMkqQ==
X-Received: by 10.98.65.215 with SMTP id g84mr11038681pfd.94.1459328614204;
        Wed, 30 Mar 2016 02:03:34 -0700 (PDT)
Received: from [192.168.12.22] (180-197-20-89.nagoya1.commufa.jp. [180.197.20.89])
        by smtp.gmail.com with ESMTPSA id s66sm4120557pfi.3.2016.03.30.02.03.32
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:03:33 -0700 (PDT)
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290280>

Hi,

`git submodule update --init --recursive` stores `gitdir` in full path into `.git` of nested submodules.
So, working directory is not portable to another directory.

On following example, `Carthage/Checkouts/Quick/Externals/Nimble/` is nested submodule and `Carthage/Checkouts/Quick/Externals/Nimble/.git` contains full path.
https://gist.github.com/norio-nomura/17ce4bdf0151185e77d9b1fcfb5a469d

Thanks,
--
Norio Nomura @norio_nomura
