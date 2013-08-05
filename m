From: Duy Nguyen <pclouds@gmail.com>
Subject: About close() in commit_lock_file()
Date: Mon, 5 Aug 2013 21:23:38 +0700
Message-ID: <CACsJy8By1cpPZ5QyVd6VhKSkd-y_E6pTYdDimK9P0wXia-uMqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 05 16:24:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Lhn-0005GR-Vw
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 16:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab3HEOYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 10:24:12 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:64964 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab3HEOYL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 10:24:11 -0400
Received: by mail-ob0-f178.google.com with SMTP id ef5so5669290obb.37
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=V0ZgoC+bicL8lwc5HDbtFrpRB80TG1O4S+Q9/D009nI=;
        b=V+Wo19qVQhZN/JAP6nK9mwIroVd+kGnaG0Ai5NY+iwMiRf77X/49no5PXZhlaw2ILj
         D3zJaZVf1M5tCRrY8wr+R93WpZzHpUj9SeonU29BZZ5gwTGkTxF/6DpytqL/zg1oPD7G
         R8zgvC5rdQk2owcswkL/rnO5cKr+ihqXlisDjNXQe7pzqBsVtV84qQEcUKQIxtwracMj
         ESGt8Q/eGovjTAyH6b7oU8uxNPR4bqcoguxx0GUGPCw1HB/5BJQ2R3l4zmjB/YZqNgdG
         K5XVkxrmtWY86DldMECCsocryQ/6iGLPm2QWzMN+/BPi/6DXsZUMDtArHs9yhRpuynNT
         Vr9w==
X-Received: by 10.60.143.35 with SMTP id sb3mr14415749oeb.62.1375712648956;
 Mon, 05 Aug 2013 07:24:08 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Mon, 5 Aug 2013 07:23:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231651>

close() is added in commit_lock_file(), before rename(), by 4723ee9
(Close files opened by lock_file() before unlinking. - 2007-11-13),
which is needed by Windows. But doesn't that create a gap between
close() and rename() on other platforms where another process can
replace .lock file with something else before rename() is executed?
Should we enclose close() in #ifdef __MINGW32__ (and maybe
__CYGWIN__)?
--
Duy
