From: Taylor Braun-Jones <taylor@braun-jones.org>
Subject: fetching from an hg remote fails with bare git repositories
Date: Tue, 4 Aug 2015 13:45:07 -0400
Message-ID: <CAKfKJYuuO+eak-L2SUVUEmoOj16bgV6LL0S=g-LzFjTxZUcRzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 19:45:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMgHO-0003BG-QW
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 19:45:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbbHDRpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 13:45:30 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35109 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbbHDRp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 13:45:29 -0400
Received: by wibxm9 with SMTP id xm9so176728915wib.0
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 10:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=braun-jones.org; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=imUhhoM/eYIufghJ5I+3uugQscxpUVxILvwrbYu3ODI=;
        b=NKL8UVJs/BEP06E7rMZm1f+IGGUffq/uda/sGn8uUbAz9a5JZG9mbLSFzu2WTmjiws
         IOaZ0XmaxwhktbkCc20zKC9tC1GpktNewB/VAV2VigO1GfLK0UZAHGZY1AvCfOs+nu9x
         EfrrVcIKjzyPuGdTlV7iK3okiZM4PDl6cIyY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=imUhhoM/eYIufghJ5I+3uugQscxpUVxILvwrbYu3ODI=;
        b=esdk8X+vslb+LNqA9e0VlibYhZoL7sqfRx6uFppLFaNOje4aR50jU/5yuejHBGuhRC
         pG5t9DRBEGOiBCM7t4mKP6rlxJiaD+5L5GoMW7z0m6CAAQXnMN1aNee/Vxfz+4GjKQ5K
         iqElPjbE7SSmhBeEhgSrh//uThAngvVCAsXqBfXGTyjX/UOf90GoVB8oSqTGY9HCkAmq
         pakenFHKqdJ6HdVXSuOOKXQbcLlVAbReSRrVKBITvgpj5Wn2ssLqRic4a55VCAYe6XwB
         fMMRvogC+E10uRzRSLaDFn62MIHZadBCRaw8jy6uYv8RhdIsrLz79+YIsEoeU1ivSd+h
         7c7Q==
X-Gm-Message-State: ALoCoQl5P3mu+iWcPyawOXEjx36xWnZvS9c+XscPEEnWfha8Jt2LXhRA6B0K/rJuUOg9Py31Qfga
X-Received: by 10.194.100.69 with SMTP id ew5mr1174288wjb.51.1438710328560;
        Tue, 04 Aug 2015 10:45:28 -0700 (PDT)
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com. [209.85.212.174])
        by smtp.gmail.com with ESMTPSA id ed10sm3510176wic.0.2015.08.04.10.45.27
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2015 10:45:27 -0700 (PDT)
Received: by wibud3 with SMTP id ud3so187288659wib.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 10:45:27 -0700 (PDT)
X-Received: by 10.180.83.137 with SMTP id q9mr1172065wiy.68.1438710327322;
 Tue, 04 Aug 2015 10:45:27 -0700 (PDT)
Received: by 10.27.13.11 with HTTP; Tue, 4 Aug 2015 10:45:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275329>

Fetching from an hg remote fails with bare git repositories. Non-bare
repositories work fine.

Steps to reproduce:

mkdir /tmp/hgrepo
cd /tmp/hgrepo
hg init
echo foo > foo.txt
hg add foo.txt
hg commit -m "add foo.txt" foo.txt
git clone hg::/tmp/hgrepo/ /tmp/gitrepo
cd /tmp/gitrepo/
git fetch # WORKS
git clone --bare hg::/tmp/hgrepo/ /tmp/gitrepo.git
cd /tmp/gitrepo.git/
git fetch # FAILS

The error message from the last line is:

fatal: bad object 0000000000000000000000000000000000000000
error: hg::/tmp/hgrepo/ did not send all necessary objects

Taylor
