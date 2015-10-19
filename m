From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] URL rewrite in .gitmodules
Date: Mon, 19 Oct 2015 15:07:31 -0700
Message-ID: <CAGZ79kY4A3nbp006JyMCgR_Oe6uHf-ECVD+6fJ-naa=XynUxRQ@mail.gmail.com>
References: <DCA9FD0F-252B-4CD7-9137-395771CBC62E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 00:07:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoIag-0007Md-Tz
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 00:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbbJSWHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 18:07:33 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36473 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbbJSWHc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Oct 2015 18:07:32 -0400
Received: by ykdz2 with SMTP id z2so72133695ykd.3
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fWgU80MQ6L+Rvb039zucyw9lgxWMjNVy+BtcnNZSZwc=;
        b=PazofgvQs8kErIgOT5GU2vs+nkaoDeGbR7xvk4WgyV57IVXuVQvwHedcwUcfacUgFN
         PAur6DQTb7T83OdWy9Uq3P6cRIi7Mn46KNP6W0kGA7QQLcDRMdHt2Wsv4hToS2wdWCJa
         PFPspl8F9GtXhnWfwWZSPRmDOtMC6jo7n73Sxy+9qN/hZhGu7+hPclyUdfhbHp1g6x7U
         eXHC0WuQLQzqjqfQWQkuUD9BmPViT3WnXAw8RKOmUF9zbaq8vlumJYqqoaji8HqtjDCW
         3sqK8gG7qq/m6RDfEj7mwmc8VSW2KlMaY2/yYW+KeloIseN/4mr8Aen4WaN8/GJrGUPa
         VYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fWgU80MQ6L+Rvb039zucyw9lgxWMjNVy+BtcnNZSZwc=;
        b=NYuESmRzb0a9KIDb0/tN8CS6zSRBqGg2Uy9SUQ1i1N8/LpnEphrWPpDMKJw5dGsl9w
         74IQdFDZ36iuNEWst/6ZgS063nONF6po/aFxqmREE4pRKrptL50/G9nbYltBsmPS81qH
         G6et58/Xma1vprNZlqR69R+M0oYx98jFoqF6vwYGYd+l3G3cdqAEJdiyxlpUMdrM/1E3
         +RL1osz12Q8efBH4EnLWPUeEZmDPXiWq7OC6vTaGjpqitnoVrG0X4y6zcYsjiG2P5wpi
         aCdOVSYU7OowzGexqV8Mu5loHGTp3/SYe1V9Y6qoJqRmN9eT44pY2fcW/ziX/sNTtFs7
         BpEQ==
X-Gm-Message-State: ALoCoQl8GNy8WtqndAlI0qpUeOL+c8tORDbFwB4145YuCdOPPTRkoLSjJzvq1EI5kWSMTncAdug7
X-Received: by 10.129.40.18 with SMTP id o18mr10438394ywo.199.1445292451599;
 Mon, 19 Oct 2015 15:07:31 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Mon, 19 Oct 2015 15:07:31 -0700 (PDT)
In-Reply-To: <DCA9FD0F-252B-4CD7-9137-395771CBC62E@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279892>

On Mon, Oct 19, 2015 at 12:28 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> I have a closed source Git repo which references an Open Source Git repo as Submodule. The Open Source Git repo references yet another Open Source repo as submodule. In order to avoid failing builds due to external services I mirrored the Open Source repos in my company network. That works great with the first level of Submodules. Unfortunately it does not work with the second level because the first level still references the "outside of company" repos. I know I can rewrite Git URLs with the git config "url.<base>.insteadOf" option. However, git configs are client specific.

I feel like this is working as intended. You only want to improve your
one client (say the buildbot) to not goto the open source site, while
the developer may do want to fetch from external sources ("Hey shiny
new code!";)


> I would prefer a solution that works without setup on any client. I also know that I could update the .gitmodules file in the Open Source repo on the first level. I also would prefer not to do this as I want to use the very same hashes as defined by the "upstream" Open Source repos.

You could carry a patch on top of the tip of the first submodule
re-pointing the nested submodule. This requires good workflows
available to deal with submodules though. (Fetch and merge or rebase,
git submodule update should be able to do that?)

>
> Is there yet another way in Git to change URLs of Submodules in the way I want it?
>
> If not, what do you think about a patch that adds a "url" section similar to the one in git config to a .gitmodules file?
>

So we have different kinds of git configs. within one repository, in
the home director (global to the one machine),
maybe you would want to have one "global" config on a network share,
such that every box in your company
reads that "company-wide" global config and acts upon that?

> Example:
> ----------
> [submodule "git"]
>         path = git
>         url=git://github.com/larsxschneider/git.git
>
> [url "mycompany.com"]
>         insteadOf = outside.com

Wouldn't that be better put into say a global git config instead of
repeating it for every submodule?

In case of the nested submodule you would need to carry the last lines
as an extra patch anyway
if this was done in the .gitmodules files? Or do you expect this to be
applied recursively (i.e. nested
submodules all the way down also substitute outside.com)


> ----------
>

Am I missing your point?

> Thanks,
> Lars--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
