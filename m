From: Dmitry Smirnov <divis1969@gmail.com>
Subject: Git 1.7.5 problem with HTTPS
Date: Tue, 15 Nov 2011 17:52:49 +0400
Message-ID: <CACf55T6BGds_D=nbb8G=m+Jwr+bHFruCs-Q0+FOO+WXitXEJ-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 14:53:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQJRm-0005Wj-9N
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 14:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817Ab1KONxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 08:53:04 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34572 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676Ab1KONwv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 08:52:51 -0500
Received: by eye27 with SMTP id 27so5706797eye.19
        for <git@vger.kernel.org>; Tue, 15 Nov 2011 05:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=dm6FNEKyQyRypFHhMdGi247VDmHE6zGAkVWrIbqq5KY=;
        b=CAj37Fa2QptgNRnnLKMKXeAoFbwjpF6UJS1nyhDbluLaFuuo94eCDWOTmEYaG/zt1N
         jH8gsgLUX7Dgb3RACYIyr7hQlQZYz1atoM6Rio+vguN4Aqx5vSxdxptx3Vpr9HaiMDOF
         LPP1i0qvr+HVXlgAg58xk3CWkYTDoh6aMzPoY=
Received: by 10.68.62.136 with SMTP id y8mr58782041pbr.87.1321365169105; Tue,
 15 Nov 2011 05:52:49 -0800 (PST)
Received: by 10.68.66.230 with HTTP; Tue, 15 Nov 2011 05:52:49 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185459>

Hi,

I have problems with downloading Android code from android.googlesource.com.

The error says: fatal: branch stable is not signed

I was trying to figure out what happens and finally came to conclusion
that this is a problem of the git.

When I try to clone the git itself using https
(https://git.kernel.org/pub/scm/git/git.git) I'm getting the follwing
error:
warning: remote HEAD refers to nonexistent ref, unable to checkout.

If I use the http URL (http://git.kernel.org/pub/scm/git/git.git) I
can clone with no problems.

I was also considering that the problem is caused by proxy. But when I
tried to clone the same git source from another host via the same
proxy, it works pretty good. The difference is the git version: on the
first host it is 1.7.5.4 (comes with Ubuntu 11.10), on the second -
1.7.0.4

I was trying to collect some tcpdump and it shows the follwoing sequence
15	1.962132	X.X.X.X	Y.Y.Y.Y	HTTP	204	CONNECT git.kernel.org:443 HTTP/1.1
17	3.687364	Y.Y.Y.Y	X.X.X.X	HTTP	105	HTTP/1.0 200 Connection established
19	3.764793	X.X.X.X	Y.Y.Y.Y	TLSv1	208	Client Hello
21	3.815135	X.X.X.X	Y.Y.Y.Y	TLSv1	215	Ignored Unknown Record
23	4.045326	Y.Y.Y.Y	X.X.X.X	TLSv1	2239	Server Hello, Certificate,
Server Key Exchange, Server Hello Done
25	4.055059	Y.Y.Y.Y	X.X.X.X	TLSv1	73	Alert (Level: Fatal, Description:
Protocol Version)

As you can see, session seems terminated with fatal alert. It looks
like client tries to use TLS 1.2 but server accepts only TLS 1.0. But
this is just assumption.
Also, it is no clear what is that Ignored Unknown Record. But it
contains uncripted text: GET
/pub/scm/git/git.git/info/refs?service=git-upload-pack HTTP/1.1
User-Agent: git/1.7.5.4 Host: git.kernel.org Accept: */* Pragma:
no-cache

So, any suggesstions?

Dmitry
