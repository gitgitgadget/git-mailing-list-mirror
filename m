From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Thu, 26 Jun 2014 18:15:57 +0200
Message-ID: <vpq8uojoddu.fsf@anie.imag.fr>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
	<53A84077.4010200@ramsay1.demon.co.uk> <53A853E9.8060801@gmail.com>
	<53A99A28.1090302@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Thu Jun 26 18:16:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0CLi-0006qT-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 18:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756952AbaFZQQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 12:16:30 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53634 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756633AbaFZQQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 12:16:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s5QGFtbr017698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 Jun 2014 18:15:55 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s5QGFvfx014460;
	Thu, 26 Jun 2014 18:15:57 +0200
In-Reply-To: <53A99A28.1090302@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Tue, 24 Jun 2014 16:32:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 26 Jun 2014 18:15:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s5QGFtbr017698
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1404404158.04802@H3J/YT7q/IIInrBueE8xiQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252504>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Hmm, maybe. The "... take advantage of the new code" refers to the
> possibility (or otherwise) of re-using your work to update these
> "older API" functions to the new API style. (also, see Junio's response).

I agree that, while caching the usual config files is the most
important, allowing other users of the config code to use non-callback
functions would be nice too.

Not really for efficiency, but because I find it far more natural to ask
"what's the value of config key XYZ" to the code than to ask "can you
parse all config keys in the file, let me know, and I'll tell you later
which ones I'm interested in".

> [In order to do this, I would have expected to see one hash table
> for each file/blob, so the singleton object took me by surprise.]

The singleton could be fine as long as it is optional. We can have
an API looking like:

int git_config_get_string(const char *key, const char **value) {
	return git_config_get_string_from(the singleton config cache,
                                          key, value);
}

int git_config_get_string_from(struct hashmap *map, const char *key, const char **value);

(or take a structure representing "a set of config files" instead of
directly the hashmap)

Now, the good news is that such API can be written later, without
breaking the API. So I'd say it's fine to keep the code as-is for now,
and make it more general later. No strong opinion, though.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
