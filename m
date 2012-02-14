From: Michael Schubert <mschub@elegosoft.com>
Subject: Re: Git submodules with usernames in the URL
Date: Tue, 14 Feb 2012 15:55:04 +0100
Message-ID: <4F3A75C8.5070201@elegosoft.com>
References: <E76DF6102FDBC04BA291EAE9A3BAECB50137C2AC6530@HE111540.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Tillmann.Crueger@telekom.de
X-From: git-owner@vger.kernel.org Tue Feb 14 15:56:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxJo3-0003lV-CP
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 15:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760744Ab2BNO4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 09:56:20 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:38317 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855Ab2BNO4T (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 09:56:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 609E5DE942;
	Tue, 14 Feb 2012 15:56:18 +0100 (CET)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0gKJRPTvmr-x; Tue, 14 Feb 2012 15:56:18 +0100 (CET)
Received: from [192.168.1.101] (e178178045.adsl.alicedsl.de [85.178.178.45])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 22927DE940;
	Tue, 14 Feb 2012 15:56:18 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120212 Thunderbird/10.0.1
In-Reply-To: <E76DF6102FDBC04BA291EAE9A3BAECB50137C2AC6530@HE111540.emea1.cds.t-internal.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190723>

On 02/14/2012 02:26 PM, Tillmann.Crueger@telekom.de wrote:
> I already had a look at the mailinglist archive, but I could not find
> any mention of this problem. There is a posting on Stackoverflow.com
> about this
> (http://stackoverflow.com/questions/7714326/git-submodule-url-not-including-username)
> with a workaround, but it would nice to have an official position.
> 
> Here is the problem:
> 
> When I am using git-submodule over an authorized https it is
> convenient to be able to specify the username directly in the url in
> the form https://user@domain.com/path/to/repo. So I am able to do a
> 
>> git submodule add https://user@domain.com/path/to/repo
> 
> Howver if I do this, the username becomes baked into the URL of the
> submodule, so other people working with the repository will not be
> able to use the submodule and have to change the URL first.
> 
> Is there an actual rationale for including the username in the URL in
> this case, or is this just because it is simpler than removing it?
> 
> One thing I noticed, is that automatically removing it would
> basically eliminate the convinience for the person who has been using
> that URL in the first place. If the username was removed every update
> would have to query the username again. Also having a username in the
> repo could be correct, in case this isn't a real user, but a role for
> using that repository.

* If the submodule repository is accessible without authentication, no
  user specific URL should go into the repository.

* If the submodule repository is not accessible without authentication,
  the user specific URL should not go into the repository either,
  because of the problem you just described. (Sure, you could add a
  "git submodule user", but..)

> Still I feel that having a username within a repository is hardly
> ever what someone wants and most often a mistake. For now I will try
> to educate everybody about this and fix all repositories where this
> goes wrong, but a better solution would be nice to have.

Git >= v1.7.9 comes with a credentials API and some helpers; see

	commit abca927dbef2c310056b8a1a8be5561212b3243a

and following or the available documentation for credentials, e.g.:

https://raw.github.com/gitster/git/master/Documentation/git-credential-store.txt

In contrib, there's a helper for the OS X keychain:

https://github.com/gitster/git/tree/master/contrib/credential

If that's no option, you would have to go with netrc / url config
approach.

HTH.
