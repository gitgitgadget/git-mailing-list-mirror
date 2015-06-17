From: Ismail Badawi <ismail@badawi.io>
Subject: git difftool --dir-diff error in the presence of symlinks to directories
Date: Wed, 17 Jun 2015 18:39:27 -0400
Message-ID: <CAFB4ZjUnhEMfjg9+sHrPp271e=V=yU_5QFHBbmPpWMkb72+ENw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 00:58:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5MHk-0007qS-Ue
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 00:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561AbbFQW6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 18:58:15 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64504 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753647AbbFQW5f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 18:57:35 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2015 18:57:34 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 678C75A685
	for <git@vger.kernel.org>; Wed, 17 Jun 2015 18:39:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=mime-version
	:date:message-id:subject:from:to:content-type; s=sasl; bh=jlIYvO
	SIEhkVoB3WZxvxgATyGKc=; b=hMMkIUlPxcSUh0S5j4NXbDF/opORg3iW8uUOZP
	ofEB2EWqvSp/AenG7YCTCLqCHW0HQqsGdOqhuK1kyI8KHyAIihbRjctzJ4zLBt/D
	RAFNlS9xs1cVi+Xd6nnzK0AcpEzeDlaLphAEXeuJm6WfuXLsTE54P3tbqVemMAa+
	2pezQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F1C65A684
	for <git@vger.kernel.org>; Wed, 17 Jun 2015 18:39:28 -0400 (EDT)
Received: from mail-yh0-f43.google.com (unknown [209.85.213.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F181B5A681
	for <git@vger.kernel.org>; Wed, 17 Jun 2015 18:39:27 -0400 (EDT)
Received: by yhan67 with SMTP id n67so44417251yha.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 15:39:27 -0700 (PDT)
X-Received: by 10.52.179.73 with SMTP id de9mr913785vdc.28.1434580767142; Wed,
 17 Jun 2015 15:39:27 -0700 (PDT)
Received: by 10.52.166.132 with HTTP; Wed, 17 Jun 2015 15:39:27 -0700 (PDT)
X-Pobox-Relay-ID: B64981AA-1541-11E5-8010-561A9F42C9D4-72591293!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271927>

Reproduce like this (using git 2.4.3):

git init
mkdir foo
touch foo/bar
git add .
git commit -m "Initial commit."
ln -s foo link
git add .
git commit -m "Add link to foo."
git difftool -d HEAD^ HEAD

That last command outputs:

fatal: Unable to hash /Users/isbadawi/test/link
hash-object /Users/isbadawi/test/link: command returned error: 128

Briefly looking at the 'git difftool' source it looks like it uses the
output of 'git diff --raw' and calls 'hash-object' on any object whose
mode is nonzero, including symlinks.

I'm not sure what the right thing to do here is -- just thought I'd
report this failure.

Thanks,
Ismail
