From: Nick <f99@2thebatcave.com>
Subject: Supporting Kerberos auth over HTTP (mod_auth_kerb)
Date: Tue, 8 Feb 2011 09:07:12 -0800
Message-ID: <AANLkTimUJjUBkbjPeq4+bsnwGqxrmj61W5qZmGQNy6Ah@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 18:07:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmr29-0000pr-2M
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 18:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab1BHRHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 12:07:14 -0500
Received: from mail-qy0-f194.google.com ([209.85.216.194]:55178 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab1BHRHN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 12:07:13 -0500
Received: by qyk4 with SMTP id 4so779149qyk.1
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 09:07:13 -0800 (PST)
Received: by 10.229.250.130 with SMTP id mo2mr14234103qcb.163.1297184833098;
        Tue, 08 Feb 2011 09:07:13 -0800 (PST)
Received: from mail-vx0-f174.google.com ([209.85.220.174])
        by mx.google.com with ESMTPS id g32sm3758689qck.22.2011.02.08.09.07.12
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 08 Feb 2011 09:07:12 -0800 (PST)
Received: by vxb37 with SMTP id 37so2605594vxb.19
        for <git@vger.kernel.org>; Tue, 08 Feb 2011 09:07:12 -0800 (PST)
Received: by 10.220.188.194 with SMTP id db2mr4983008vcb.138.1297184832282;
 Tue, 08 Feb 2011 09:07:12 -0800 (PST)
Received: by 10.220.208.70 with HTTP; Tue, 8 Feb 2011 09:07:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166360>

Has anyone gotten negotiable authentication to work with git over http
using mod_auth_kerb on the server end?  I am unable to get a git
client to function correctly in this scenario.  I am defining
"correctly" as the following:

When a valid kerberos ticket is available, use that without prompting
for credentials.  If for some reason that fails, prompt for
credentials and try again using HTTP basic auth.

If no valid kerberos ticket is available, prompt for credentials and
try using HTTP basic auth.



So far the behavior I have been able to reproduce:

When 'KrbMethodNegotiate off' is set on the server, the git client
will always prompt for username and password and use them.  This is
very intuitive from the user perspective, but does not take advantage
of the kerberos ticket for single sign-on.

When 'KrbMethodNegotiate on' is set on the server, the git client will
always prompt for username and password, but ignore them.  If a valid
kerberos ticket is available, the command will complete after any
arbitrary text is entered into the username and password prompts.  If
a valid kerberos ticket is not available, the command will fail even
if the correct username and password is entered.

Using some combinations of various git and curl versions and compile
options will not even get that far, and respond immediately with a
401.


I have tried several different versions of git, including the latest
1.7.4.  I have tried several different versions of curl, including the
latest 7.12.3.  I have tried several different curl compile-time
configuration options, including --with-spenego (using fbopenssl) and
--with-gssapi.
