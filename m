From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [RFC/PATCH] push: deny policy to prevent pushes to unwanted
 remotes.
Date: Mon, 6 Jun 2016 13:39:23 +0200 (CEST)
Message-ID: <998280064.353519.1465213163063.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160604145101.21928-1-Antoine.Queru@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	larsxschneider@gmail.com, rsbecker@nexbridge.com, aaron@schrab.com,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, peff@peff.net
To: Antoine Queru <Antoine.Queru@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 13:27:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9sh3-0007or-3a
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 13:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbcFFL1h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 07:27:37 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:44337 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751006AbcFFL1g convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 07:27:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 222BA258D;
	Mon,  6 Jun 2016 13:27:33 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TibaKGi6bvqa; Mon,  6 Jun 2016 13:27:33 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 103B72583;
	Mon,  6 Jun 2016 13:27:33 +0200 (CEST)
In-Reply-To: <20160604145101.21928-1-Antoine.Queru@grenoble-inp.org>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: push: deny policy to prevent pushes to unwanted remotes.
Thread-Index: 3RX7lZmCGRn7uHRwpAOfYIYKt2L9cA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296502>

Hi Antoine,

Antoine Queru <Antoine.Queru@grenoble-inp.org> writes:
> [...]
> +For example, if we set up the configuration variables like this:
> +
> +-------------------------------
> +git config --add remote.pushBlacklist repository.com
> +git config --add remote.pushWhitelist repository.com/Special_Folder
> +-------------------------------
> +
> +Pushes like this  will be accepted:
> +-------------------------------
> +git push repository.com/Special_Path/*
> +-------------------------------

According to your previous `git config`, it should be:
	git push repository.com/Special_Folder/*

> +
> +While this one for example will be denied:
> +-------------------------------
> +git push repository.com/Other_Path/
> +-------------------------------
> +
> [...]
> +/*
> + *NEEDSWORK: Ugly because file://... is recognized as an url, and we
> + *may want to compare it to local path without this scheme. Forcing
> + *the user to put file:// before every local path would make the cod=
e
> + *easier and avoid confusion with a distant repo like 'github.com'
> + *which is not an url.
> + */

Style: space after '*' (when there is text after), meaning:
	/*
	 * NEEDSWORK: Ugly because file://... is recognized [...]
	 * [...]
	 */

> +static int longest_prefix_size(const char* target_str,
> +                                const struct string_list *list)

That might just be my mailer but this line is not properly lined up
with the previous one (one space too much).
It should be:
static int longest_prefix_size(const char* target_str,
			       const struct string_list *list)

> [...]
> +        for_each_string_list_item(curr_item, list) {
> +                struct url_info curr_url;
> +                const char *curr_str =3D curr_item->string;
> +                skip_prefix(curr_str, "file://", &curr_str);
> +                url_normalize(curr_str, &curr_url);
> +                if (target_url.url &&
> +                    curr_url.url &&

You can put target_url.url and curr_url.url on the same line.

> +                    target_url.scheme_len =3D=3D curr_url.scheme_len=
 &&
> +                    !strncmp(target_url.url,curr_url.url,curr_url.sc=
heme_len))

Style: space after ','.

With those two things, the condition would look like this:

		if (target_url.url && curr_url.url &&
		    target_url.scheme_len =3D=3D curr_url.scheme_len &&
		    !strncmp(target_url.url, curr_url.url, curr_url.scheme_len))

> [...]
> +        whitelist_size =3D longest_prefix_size(repo, whitelist);
> +        blacklist_size =3D longest_prefix_size(repo, blacklist);
> +
> +        check_length_prefix(whitelist_size, blacklist_size, repo, de=
ny_message, default_policy);

This line is above 80 characters, so:

	check_length_prefix(whitelist_size, blacklist_size, repo, deny_message=
,
			    default_policy);

> [...]
> +test_expect_success 'setup' '
> +        git init --bare blacklist/ &&
> +        git init --bare whitelist/ &&
> +        git init --bare blacklist/allow &&
> +        test_commit commit &&
> +        echo "fatal: Pushing to this remote using this protocol is f=
orbidden" > forbidden
> +'
> +
> +test_expect_success 'basic case' '
> +        git config --add remote.pushBlacklist http://blacklist.com &=
&

You use `git config` instead of `test_config`, meaning that the
configuration you introduce will persist after the test.

It is not really a problem here since for the other tests you don't
use `git config --add` so the configuration will be
overwritten. However I still think you should use `test_config` to
avoid causing trouble to potential future tests that would use
`--add` and expect a clean state.

> [...]
> +test_expect_success 'local path with file://' '
> +        git config remote.pushBlacklist file://blacklist &&
> +        test_must_fail git push blacklist HEAD 2> result &&
> +        test_cmp result forbidden
> +'

(you forgot a new line here)

> +test_expect_success 'only one scheme allowed' '
> +        git config remote.pushDefaultPolicy deny &&
> +        git config remote.pushWhitelist http://blacklist.com &&
> +        test_must_fail git push https://blacklist.com HEAD 2> result=
 &&
> +        test_cmp result forbidden
> +'
> +
> +test_expect_success 'denied repo in allowed repo' '

'allowed repo in denied remote'? In any case the current title is
misleading for me.

> +        git config remote.pushBlacklist blacklist &&
> +        git config --add remote.pushWhitelist blacklist/allow &&
> +        git push blacklist/allow HEAD
> +'

Thanks,
R=C3=A9mi
