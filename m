From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/8] git_remote_helpers: fix input when running under
 Python 3
Date: Sun, 13 Jan 2013 04:26:39 +0100
Message-ID: <50F2296F.8030909@alum.mit.edu>
References: <cover.1358018078.git.john@keeping.me.uk> <a8c3aabfab64f49fa0cbb2d45bda79997a875ee8.1358018078.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 13 04:28:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuEFN-00082K-Ga
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 04:28:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab3AMD0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 22:26:44 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:59952 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754239Ab3AMD0o (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2013 22:26:44 -0500
X-AuditID: 12074413-b7f786d0000008bb-54-50f229739a96
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id EF.79.02235.37922F05; Sat, 12 Jan 2013 22:26:43 -0500 (EST)
Received: from [192.168.69.140] (p57A25D0F.dip.t-dialin.net [87.162.93.15])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0D3Qe0m001684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 12 Jan 2013 22:26:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <a8c3aabfab64f49fa0cbb2d45bda79997a875ee8.1358018078.git.john@keeping.me.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsUixO6iqFus+SnAoH+upMXVLT4WBx/nWXRd
	6WayuHF+F6vF/BtnGR1YPXbOusvucfbRA2aPZV87WTw+b5ILYInitklKLCkLzkzP07dL4M74
	vOMQa8F+noq1P04yNTC+4exi5OSQEDCRaHpwlgnCFpO4cG89WxcjF4eQwGVGicnTZjJCOKeZ
	JDqWfGYHqeIV0JaYePgXG4jNIqAqMetOI1g3m4CuxKKeZjBbVCBAYvGSc1D1ghInZz5hAbFF
	gOqnfboBFmcWWMYo0XrLAsQWFgiReD5nC9SyJkaJS8uvs3YxcnBwCkRKXDvuCVGvI/Gu7wEz
	hC0vsf3tHOYJjAKzkKyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfVyM0v0
	UlNKNzFCAlt4B+Ouk3KHGAU4GJV4eGe9+BggxJpYVlyZe4hRkoNJSZSXU+NTgBBfUn5KZUZi
	cUZ8UWlOavEhRgkOZiUR3hJuoBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxW
	hoNDSYK3DmSoYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChW44uB0QqS4gHaqwPS
	zltckJgLFIVoPcWoy7H9d/tzRiGWvPy8VClx3hiQIgGQoozSPLgVsDT2ilEc6GNhXj2QKh5g
	CoSb9ApoCRPQkrMX3oMsKUlESEk1MDoXS284GdDVkpu1U6nAgSMpcur9rTPPP5bmu3SjesFG
	p1v+gWdfvmBbslX2QvKdWz9O8jyX5DsVV/XMU6r+C0969e3rH942st/6KH51wYeT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213329>

On 01/12/2013 08:23 PM, John Keeping wrote:
> Although 2to3 will fix most issues in Python 2 code to make it run under
> Python 3, it does not handle the new strict separation between byte
> strings and unicode strings.  There is one instance in
> git_remote_helpers where we are caught by this.
> 
> Fix it by explicitly decoding the incoming byte string into a unicode
> string.  In this instance, use the locale under which the application is
> running.
> 
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  git_remote_helpers/git/importer.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git_remote_helpers/git/importer.py b/git_remote_helpers/git/importer.py
> index e28cc8f..6814003 100644
> --- a/git_remote_helpers/git/importer.py
> +++ b/git_remote_helpers/git/importer.py
> @@ -20,7 +20,7 @@ class GitImporter(object):
>          """Returns a dictionary with refs.
>          """
>          args = ["git", "--git-dir=" + gitdir, "for-each-ref", "refs/heads"]
> -        lines = check_output(args).strip().split('\n')
> +        lines = check_output(args).decode().strip().split('\n')
>          refs = {}
>          for line in lines:
>              value, name = line.split(' ')
> 

Won't this change cause an exception if the branch names are not all
valid strings in the current locale's encoding?  I don't see how this
assumption is justified (e.g., see git-check-ref-format(1) for the rules
governing reference names).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
