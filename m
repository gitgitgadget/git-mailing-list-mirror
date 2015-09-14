From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git Deployment using existing multiple environments
Date: Mon, 14 Sep 2015 01:32:39 -0700
Message-ID: <CA+P7+xq0ZPOAOONA9x9x_CYt1yf5J4Qcr5oQdQsbtu3iH3ehmw@mail.gmail.com>
References: <BAY180-W16B5F49FFD3614D666B232C25F0@phx.gbl> <8797177dd247d4ef903603cbe6c57d7d@dscho.org>
 <BAY180-W55A5095CC7E1322EA80876C25D0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Sukhwinder Singh <php_programmer_india@hotmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 10:34:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbPDI-0002sv-M3
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 10:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbbINIeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 04:34:07 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38324 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbbINIdC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Sep 2015 04:33:02 -0400
Received: by igxx6 with SMTP id x6so76650103igx.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=kzUr0gXl0tkKPn1TAgupatHu62pp8TsdsRfJ2sGGJs4=;
        b=cYtQHqM0BIwmKwK0ylkc7QSouYoEVULf7wAOQi7fOQK1RtsdWojNabwqciw9qYKwfd
         TP7F0exHqIbbS8WnFdjOiifFNtnaNWI3fwGVRraAD0VHWdxFJXuI7PZhSZghjRlHfSH0
         Fbr0ZbDXTHPTrWtL87OyXGL2ubDZOZKT6asYhEFPq9MJAB0awaXHdKWtDu+Z+5nkQjb9
         R2lG/yqQ9824FRxKiJlMPoewggL39HJtBTUGv9ZSLyHeH1MY4YV2zeU/HTFWsQ8N/COH
         Z+sLDZn0eqUa8mazwhY4vM4f/1O5vacoZzOasJVr/LydCp6hTcyad1nejnnFM7lF6M1d
         FRyw==
X-Received: by 10.50.3.66 with SMTP id a2mr16323155iga.92.1442219579304; Mon,
 14 Sep 2015 01:32:59 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Mon, 14 Sep 2015 01:32:39 -0700 (PDT)
In-Reply-To: <BAY180-W55A5095CC7E1322EA80876C25D0@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277811>

On Sun, Sep 13, 2015 at 10:55 PM, Sukhwinder Singh
<php_programmer_india@hotmail.com> wrote:
> Thank you for the reply. Let's say I do setup three different repositories then how can we move work from one repository to the other. For example, from Test Environment to UAT. If there are any links that you can provide me that I can check, it'll be great.
>
> Regards,
> Sukhwinder Singh
>

Generally speaking there are two ways of moving work from one
repository to another. The first is the "pull" where you request data
from a remote repository and then merge that data into your own. This
is what you're doing when you perform a clone, a fetch, or a pull.
It's what everyone does all the time when working with a local copy of
a "trusted" remote repository. It can also be done between two
"trusted" remotes, if your workflow is more distributed. (ie: more
than one "official" source).

The second form of moving work is the "push" where you upload your
work into another repository. This is most commonly used when the
workflow is "centralized". By that I mean there is a single
authoritative repository. Or when you are moving your own work on a
local machine into a remotely accessible machine for others to pull
from.

As Johannes said above, you really need to determine the work flow and
team style you want before you can really understand the best way to
setup repositories. For example, if you setup using a distributed
chain of command, you can have one person be the "maintainer" of each
given trusted repository. Then, maintainers can pull (or
equivalent-ly, pull-request) between each other. This is generally how
a project would work when using github. One person is the maintainer,
then a developer "forks" the project, makes some changes, then
requests that the maintainer pull these changes. The maintainer has
final say and will perform the final merge in cases of conflict. In
addition, maintainer is the one who says "this is ok to go into this
repository".

You can also instead opt to use a single centralized repository. Thus,
developers would work on code and get it ready to submit, and then
simply perform a push. If the push requires a merge git will tell the
user to update. There are many tools such as server side hooks in
order to enforce various behaviors.

This flow generally doesn't use sole maintainers, as each developer
has access to push directly. It may work well for smaller teams or for
dedicated teams who don't change developers often.

A lot comes down to how your team is structured. Do you have one
person who's job can be to maintain the repository? Do you have
several developers who don't want to be the sole owner? Is your team
willing to function much more distributed?

In the end, it's generally always a good idea to designate at least
one repository as the "authority" so that everyone knows where to look
for release tags and other such data.

Myself, I would say that I prefer to use the pull-request model so
that code gets more review, as "push" based models tend not to do
review. (Exception: Gerrit, but this uses "git push" on the command
line to do something very much not like a push)

Regards,
Jake
