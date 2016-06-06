From: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
Subject: Re: [RFC/PATCH] push: deny policy to prevent pushes to unwanted
 remotes.
Date: Mon, 6 Jun 2016 15:43:59 +0200 (CEST)
Message-ID: <2104102670.380496.1465220639026.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160604145101.21928-1-Antoine.Queru@grenoble-inp.org> <998280064.353519.1465213163063.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Queru <Antoine.Queru@grenoble-inp.org>,
	git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	larsxschneider@gmail.com, rsbecker@nexbridge.com, aaron@schrab.com,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, peff@peff.net
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 06 15:36:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9uhm-0002pO-ED
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 15:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbcFFNg2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 09:36:28 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:40409 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751293AbcFFNg2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 09:36:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 159D92591;
	Mon,  6 Jun 2016 15:36:25 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IV5V12ovxmVY; Mon,  6 Jun 2016 15:36:25 +0200 (CEST)
Received: from zm-int-mbx6.grenet.fr (zm-int-mbx6.grenet.fr [130.190.242.145])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 031AB2590;
	Mon,  6 Jun 2016 15:36:25 +0200 (CEST)
In-Reply-To: <998280064.353519.1465213163063.JavaMail.zimbra@ensimag.grenoble-inp.fr>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: push: deny policy to prevent pushes to unwanted remotes.
Thread-Index: 3RX7lZmCGRn7uHRwpAOfYIYKt2L9cGyx3cuV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296507>



----- Mail original -----
> Hi Antoine,
>=20
> Antoine Queru <Antoine.Queru@grenoble-inp.org> writes:
> > [...]
> > +For example, if we set up the configuration variables like this:
> > +
> > +-------------------------------
> > +git config --add remote.pushBlacklist repository.com
> > +git config --add remote.pushWhitelist repository.com/Special_Folde=
r
> > +-------------------------------
> > +
> > +Pushes like this  will be accepted:
> > +-------------------------------
> > +git push repository.com/Special_Path/*
> > +-------------------------------
>=20
> According to your previous `git config`, it should be:
> 	git push repository.com/Special_Folder/*
>=20
> > +
> > +While this one for example will be denied:
> > +-------------------------------
> > +git push repository.com/Other_Path/
> > +-------------------------------
> > +
> > [...]
> > +/*
> > + *NEEDSWORK: Ugly because file://... is recognized as an url, and =
we
> > + *may want to compare it to local path without this scheme. Forcin=
g
> > + *the user to put file:// before every local path would make the c=
ode
> > + *easier and avoid confusion with a distant repo like 'github.com'
> > + *which is not an url.
> > + */
>=20
> Style: space after '*' (when there is text after), meaning:
> 	/*
> 	 * NEEDSWORK: Ugly because file://... is recognized [...]
> 	 * [...]
> 	 */
>=20
> > +static int longest_prefix_size(const char* target_str,
> > +                                const struct string_list *list)
>=20
> That might just be my mailer but this line is not properly lined up
> with the previous one (one space too much).
> It should be:
> static int longest_prefix_size(const char* target_str,
> 			       const struct string_list *list)
>=20
> > [...]
> > +        for_each_string_list_item(curr_item, list) {
> > +                struct url_info curr_url;
> > +                const char *curr_str =3D curr_item->string;
> > +                skip_prefix(curr_str, "file://", &curr_str);
> > +                url_normalize(curr_str, &curr_url);
> > +                if (target_url.url &&
> > +                    curr_url.url &&
>=20
> You can put target_url.url and curr_url.url on the same line.
>=20
> > +                    target_url.scheme_len =3D=3D curr_url.scheme_l=
en &&
> > +
> > !strncmp(target_url.url,curr_url.url,curr_url.scheme_len))
>=20
> Style: space after ','.
>=20
> With those two things, the condition would look like this:
>=20
> 		if (target_url.url && curr_url.url &&
> 		    target_url.scheme_len =3D=3D curr_url.scheme_len &&
> 		    !strncmp(target_url.url, curr_url.url, curr_url.scheme_len))
>=20
> > [...]
> > +        whitelist_size =3D longest_prefix_size(repo, whitelist);
> > +        blacklist_size =3D longest_prefix_size(repo, blacklist);
> > +
> > +        check_length_prefix(whitelist_size, blacklist_size, repo,
> > deny_message, default_policy);
>=20
> This line is above 80 characters, so:
>=20
> 	check_length_prefix(whitelist_size, blacklist_size, repo, deny_messa=
ge,
> 			    default_policy);
>=20
> > [...]
> > +test_expect_success 'setup' '
> > +        git init --bare blacklist/ &&
> > +        git init --bare whitelist/ &&
> > +        git init --bare blacklist/allow &&
> > +        test_commit commit &&
> > +        echo "fatal: Pushing to this remote using this protocol is
> > forbidden" > forbidden
> > +'
> > +
> > +test_expect_success 'basic case' '
> > +        git config --add remote.pushBlacklist http://blacklist.com=
 &&
>=20
> You use `git config` instead of `test_config`, meaning that the
> configuration you introduce will persist after the test.
>=20
> It is not really a problem here since for the other tests you don't
> use `git config --add` so the configuration will be
> overwritten. However I still think you should use `test_config` to
> avoid causing trouble to potential future tests that would use
> `--add` and expect a clean state.
>=20
> > [...]
> > +test_expect_success 'local path with file://' '
> > +        git config remote.pushBlacklist file://blacklist &&
> > +        test_must_fail git push blacklist HEAD 2> result &&
> > +        test_cmp result forbidden
> > +'
>=20
> (you forgot a new line here)
>=20
> > +test_expect_success 'only one scheme allowed' '
> > +        git config remote.pushDefaultPolicy deny &&
> > +        git config remote.pushWhitelist http://blacklist.com &&
> > +        test_must_fail git push https://blacklist.com HEAD 2> resu=
lt &&
> > +        test_cmp result forbidden
> > +'
> > +
> > +test_expect_success 'denied repo in allowed repo' '
>=20
> 'allowed repo in denied remote'? In any case the current title is
> misleading for me.
>=20
> > +        git config remote.pushBlacklist blacklist &&
> > +        git config --add remote.pushWhitelist blacklist/allow &&
> > +        git push blacklist/allow HEAD
> > +'
>=20
> Thanks,
> R=C3=A9mi
>=20

Hello R=C3=A9mi, thanks you for your input ! I'll make the appropriate =
changes=20
and send a new version as soon as i can !
