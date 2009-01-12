From: "Peter Spierenburg" <ionlyusethisaddressforlists@gmail.com>
Subject: git/webdav is refusing to authenticate properly.
Date: Mon, 12 Jan 2009 14:54:22 -0700
Message-ID: <137c54e10901121354l284f11ag675abb003fc83e93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 22:56:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUlK-0002aq-K4
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757688AbZALVy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757693AbZALVyZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:54:25 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:53240 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbZALVyY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 16:54:24 -0500
Received: by wf-out-1314.google.com with SMTP id 27so11611806wfd.4
        for <git@vger.kernel.org>; Mon, 12 Jan 2009 13:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=SXwJosFvmtWusXrJSs+Kn9/TKLnSE0lcKCx1e9XOjPw=;
        b=YyUd7p3fikcb5Axd3pCT65ciWiJlXBLTL7HnQygLPldQI7WASNKve//D7Qzh/oS7Te
         +/Ui8MXS86dY2DJJK6X7Vn3Vl1YB9mN+LMFSFqtj6JjvjkLVyuFbhnLfDVq8HmshIuRY
         L9Ql6SiF+3SmEXsmQKrnYC9D53sEa2AkrvXeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Xs/D3mNLcAq/G11WHTsenHxAmCTu5CoKXwpZdI76prpouuHRJFBY8nAaYPtzxMRFbg
         Y+XXSY8Xf5VeUqjGffqkmidAiR6t+1e/BWXeyseyHcoesqEHkvtct6Pqa3mbNQFWjOxq
         wlbykdSYP+fKz7WLRl44yJN8jntQP3qznoPC0=
Received: by 10.142.141.21 with SMTP id o21mr7839403wfd.308.1231797262880;
        Mon, 12 Jan 2009 13:54:22 -0800 (PST)
Received: by 10.143.35.19 with HTTP; Mon, 12 Jan 2009 13:54:22 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105397>

Greetings,

I'm trying to push a local git repository to a remote site using
WebDAV, but it is eating my lunch.

My first attempt includes a username but no password in the url:

$ git-config remote.upload.url
http://peter@spierepf.dyndns.org/git/ToastMeister.git/
$ git push upload master
Fetching remote heads...
  refs/
  refs/tags/
  refs/heads/
updating 'refs/heads/master'
  from 0000000000000000000000000000000000000000
  to   0f5f3df5e289b5696d7319dcfabc2383192f306a
Unable to create branch path
http://peter@spierepf.dyndns.org/git/ToastMeister.git/refs
Unable to lock remote branch refs/heads/master
error: failed to push some refs to
'http://peter@spierepf.dyndns.org/git/ToastMeister.git/'

What surprises me here is that git never asks for a password, so
naturally, my apache webserver will refuse the request:

==> /var/log/apache2/access.log <==
208.38.1.1 - - [12/Jan/2009:11:52:07 -0700] "PROPFIND
/git/ToastMeister.git/ HTTP/1.1" 207 569 "-" "git/1.5.6.3"
208.38.1.1 - - [12/Jan/2009:11:52:08 -0700] "HEAD
/git/ToastMeister.git/info/refs HTTP/1.1" 404 - "-" "git/1.5.6.3"
208.38.1.1 - - [12/Jan/2009:11:52:08 -0700] "HEAD
/git/ToastMeister.git/objects/info/packs HTTP/1.1" 404 - "-"
"git/1.5.6.3"

==> /var/log/apache2/error.log <==
[Mon Jan 12 11:52:08 2009] [error] [client 208.38.1.1] File does not
exist: /var/www/git/ToastMeister.git/info/refs
[Mon Jan 12 11:52:08 2009] [error] [client 208.38.1.1] File does not
exist: /var/www/git/ToastMeister.git/objects/info/packs

==> /var/log/apache2/access.log <==
208.38.1.1 - - [12/Jan/2009:11:52:08 -0700] "PROPFIND
/git/ToastMeister.git/refs/ HTTP/1.1" 207 2587 "-" "git/1.5.6.3"
208.38.1.1 - - [12/Jan/2009:11:52:08 -0700] "PROPFIND
/git/ToastMeister.git/refs/tags/ HTTP/1.1" 207 933 "-" "git/1.5.6.3"
208.38.1.1 - - [12/Jan/2009:11:52:08 -0700] "PROPFIND
/git/ToastMeister.git/refs/heads/ HTTP/1.1" 207 934 "-" "git/1.5.6.3"
208.38.1.1 - peter [12/Jan/2009:11:52:08 -0700] "MKCOL
/git/ToastMeister.git/refs HTTP/1.1" 401 598 "-" "git/1.5.6.3"

==> /var/log/apache2/error.log <==
[Mon Jan 12 11:52:08 2009] [warn] [client 208.38.1.1] [12697]
auth_ldap authenticate: user peter authentication failed; URI
/git/ToastMeister.git/refs [Empty password not allowed][Invalid
credentials]
[Mon Jan 12 11:52:08 2009] [error] [client 208.38.1.1] user peter:
authentication failure for "/git/ToastMeister.git/refs": Password
Mismatch

So next, I'll try adding a password to the URL:

$ git-config remote.upload.url
http://peter:<secret>@spierepf.dyndns.org/git/ToastMeister.git/
$ git push upload master
Fetching remote heads...
  refs/
  refs/tags/
  refs/heads/
updating 'refs/heads/master'
  from 0000000000000000000000000000000000000000
  to   0f5f3df5e289b5696d7319dcfabc2383192f306a
Unable to create branch path
http://peter:<secret>@spierepf.dyndns.org/git/ToastMeister.git/refs
Unable to lock remote branch refs/heads/master
error: failed to push some refs to
'http://peter:<secret>@spierepf.dyndns.org/git/ToastMeister.git/'

>From the client side, the result appears identical, but on the server:

==> /var/log/apache2/access.log <==
208.38.1.1 - - [12/Jan/2009:11:52:50 -0700] "PROPFIND
/git/ToastMeister.git/ HTTP/1.1" 207 581 "-" "git/1.5.6.3"
208.38.1.1 - - [12/Jan/2009:11:52:50 -0700] "HEAD
/git/ToastMeister.git/info/refs HTTP/1.1" 404 - "-" "git/1.5.6.3"
208.38.1.1 - - [12/Jan/2009:11:52:51 -0700] "HEAD
/git/ToastMeister.git/objects/info/packs HTTP/1.1" 404 - "-"
"git/1.5.6.3"

==> /var/log/apache2/error.log <==
[Mon Jan 12 11:52:50 2009] [error] [client 208.38.1.1] File does not
exist: /var/www/git/ToastMeister.git/info/refs
[Mon Jan 12 11:52:51 2009] [error] [client 208.38.1.1] File does not
exist: /var/www/git/ToastMeister.git/objects/info/packs

==> /var/log/apache2/access.log <==
208.38.1.1 - - [12/Jan/2009:11:52:51 -0700] "PROPFIND
/git/ToastMeister.git/refs/ HTTP/1.1" 207 2587 "-" "git/1.5.6.3"
208.38.1.1 - - [12/Jan/2009:11:52:51 -0700] "PROPFIND
/git/ToastMeister.git/refs/tags/ HTTP/1.1" 207 933 "-" "git/1.5.6.3"
208.38.1.1 - - [12/Jan/2009:11:52:51 -0700] "PROPFIND
/git/ToastMeister.git/refs/heads/ HTTP/1.1" 207 934 "-" "git/1.5.6.3"
208.38.1.1 - peter [12/Jan/2009:11:52:51 -0700] "MKCOL
/git/ToastMeister.git/refs HTTP/1.1" 301 458 "-" "git/1.5.6.3"
208.38.1.1 - - [12/Jan/2009:11:52:51 -0700] "MKCOL
/git/ToastMeister.git/refs/ HTTP/1.1" 401 598 "-" "git/1.5.6.3"

It looks like the client is attempting to create a collection that
already exists, gets redirected (301 - Moved Permanently), forgets to
authenticate on the next request, gets denied (401 - Unauthorized),
and gives up.

Any idea why this is happening?

Peter-Frank Spierenburg.
