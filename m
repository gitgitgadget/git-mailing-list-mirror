Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B771122D7B9
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194819; cv=none; b=pHbdJF6gqiQqtDgRM2Pg/udjC3g3R6HdlyR/tb/TkG4zU1qNovbtKE3bCqw/jzIR6G6xWqcwN7biN9ZrtP9TI1NXfvQlcePsHBmzn/nbfTQ0rpM9bNyLRK3Q5muhoFTJte8/pVJVzl3AEF6vQXvR8PiVt71VkKN6OA+KoMtpoAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194819; c=relaxed/simple;
	bh=YQFPfSVbsSmFklxKkU8Sv7IUL+deHZB4dUdHWdW14fc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u61GPNABd+T+ESfh1Octp7BLSdFwF9NPmMVK6fkmirN+YQYP5V+5dOLAROYnD1maTv63ZxvPFhMTGT7pqy2RIllJJOlhBgwDZHrh3WKh27aH1q7IxZp33VDdo9SPz4ovz+BpFMfuiRjmq4cec0O1n5Gd2G36J/vybvG0zrWjpZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=cc/mJU8e; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="cc/mJU8e"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 65BGJw1J011685-65BGJw1L011685
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 11 Jun 2026 19:19:58 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1wXi8M-00G7cd-DJ;
	Thu, 11 Jun 2026 19:19:58 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 11 Jun
 2026 19:19:58 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 746fb8e9;
	Thu, 11 Jun 2026 16:19:57 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Junio C Hamano
	<gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>, Tuomas Ahola
	<taahol@utu.fi>
Subject: [PATCH v3 1/3] doc: config: terminate runaway lists
Date: Thu, 11 Jun 2026 19:19:44 +0300
Message-ID: <20260611161946.12166-2-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260611161946.12166-1-taahol@utu.fi>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260611161946.12166-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ex19-09.utu.fi (130.232.247.49) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZW0gYDQ4OKBgNDg5GBg0cSFhI
 WkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhdSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFleSAIGRgkeAQQJKA4a
 DQ1GDhpIWEhbWkgDGgEbHAcODg0aAAkdDxsKCQMDKA4JGxwFCQEERgsHBUhYSFlbSBgNDg4oGA0ODkYGDRxIWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=J9ag1y+ci8o+uq+LOrbJvVkpE/jjTiktA3vwK+NA/DY=;
 b=cc/mJU8e1xvs2txjoJP62fxipr+jLER/QuJt14Flxnr6Hap7tfgHBNWFTY9UbiDy9R+gQ1WPioEz
	wdSVyEtcnIIqufQnJ5Exxaw051LWsW/hehuAe0W5J8ixTLFFfPeONdSLSfZtx5/S6w56CAQAe8T0
	SPu/ejNiJjrfFX3QEdm+XvM9sOxc6LK+3E10adgVH03tcuJirr37aYmf1uRPYL5Xnly8V99cLTBS
	wVbwc9nVD1tA/ZIG8ljsYsJr581DJMzqUE+arekcU1rdkwEvwva43V1wX9+BP9bWHoLrIX6Bwz5w
	+PeUaJAN5tYX0xClsZ/7VJRyuOafOG4MjkKSBg==

There are many places in git-config(1) where paragraphs that should
logically come after a list are instead appended to the last item of
the list.  This is a well-documented quirk of AsciiDoc, and can be
mitigated by enclosing the list in an open block:

	--
	* first item
	* last item
	--
	+
	New paragraph after the list.

Fix the issue accordingly.

Signed-off-by: Tuomas Ahola <taahol@utu.fi>
---

Notes (doc-diff):
    diff --git a/29bd7ed5127255713c1ac2f43b7c6f257d7b4594/home/taahol/share/man/man1/git-config.1 b/c9131b23fd1c8611fde5664fcfd4e6d5283648ad/home/taahol/share/man/man1/git-config.1
    index 326782e637..d915897ca5 100644
    --- a/29bd7ed5127255713c1ac2f43b7c6f257d7b4594/home/taahol/share/man/man1/git-config.1
    +++ b/c9131b23fd1c8611fde5664fcfd4e6d5283648ad/home/taahol/share/man/man1/git-config.1
    @@ -234,10 +234,10 @@ OPTIONS
                    sanity-check is performed to ensure that the given value is
                    canonicalize-able as an ANSI color, but it is written as-is.
    
    -               If the command is in list mode, then the --type <type> argument
    -               will apply to each listed config value. If the value does not
    -               successfully parse in that format, then it will be omitted from
    -               the list.
    +           If the command is in list mode, then the --type <type> argument
    +           will apply to each listed config value. If the value does not
    +           successfully parse in that format, then it will be omitted from the
    +           list.
    
            --bool, --int, --bool-or-int, --path, --expiry-date
                Historical options for selecting a type specifier. Prefer instead
    @@ -841,9 +841,9 @@ CONFIGURATION FILE
                    Boolean false literals are no, off, false, 0 and the empty
                    string.
    
    -               When converting a value to its canonical form using the
    -               --type=bool type specifier, git config will ensure that the
    -               output is "true" or "false" (spelled in lowercase).
    +           When converting a value to its canonical form using the --type=bool
    +           type specifier, git config will ensure that the output is "true" or
    +           "false" (spelled in lowercase).
    
            integer
                The value for many variables that specify various sizes can be
    @@ -5869,28 +5869,26 @@ CONFIGURATION FILE
                    exactly match the value advertised by the server for the
                    "token" field.
    
    -               If any of these conditions is not met for any field name listed
    -               in promisor.checkFields, the advertised remote "foo" is
    -               rejected.
    +           If any of these conditions is not met for any field name listed in
    +           promisor.checkFields, the advertised remote "foo" is rejected.
    
    -               For the "partialCloneFilter" field, this allows the client to
    -               ensure that the server’s filter matches what it expects
    -               locally, preventing inconsistencies in filtering behavior. For
    -               the "token" field, this can be used to verify that
    -               authentication credentials match expected values.
    +           For the "partialCloneFilter" field, this allows the client to
    +           ensure that the server’s filter matches what it expects locally,
    +           preventing inconsistencies in filtering behavior. For the "token"
    +           field, this can be used to verify that authentication credentials
    +           match expected values.
    
    -               Field values are compared case-sensitively.
    +           Field values are compared case-sensitively.
    
    -               The "name" and "url" fields are always checked according to the
    -               promisor.acceptFromServer policy, independently of this
    -               setting.
    +           The "name" and "url" fields are always checked according to the
    +           promisor.acceptFromServer policy, independently of this setting.
    
    -               The field names and values should be passed by the server
    -               through the "promisor-remote" capability by using the
    -               promisor.sendFields config variable. The fields are checked
    -               only if the promisor.acceptFromServer config variable is not
    -               set to "None". If set to "None", this config variable has no
    -               effect. See gitprotocol-v2(5).
    +           The field names and values should be passed by the server through
    +           the "promisor-remote" capability by using the promisor.sendFields
    +           config variable. The fields are checked only if the
    +           promisor.acceptFromServer config variable is not set to "None". If
    +           set to "None", this config variable has no effect. See gitprotocol-
    +           v2(5).
    
            promisor.storeFields
                A comma or space separated list of additional remote related field
    @@ -6630,15 +6628,15 @@ CONFIGURATION FILE
                    the top-level --git-dir command-line option, or the GIT_DIR
                    environment variable (see git(1)).
    
    -               If you do not use bare repositories in your workflow, then it
    -               may be beneficial to set safe.bareRepository to explicit in
    -               your global config. This will protect you from attacks that
    -               involve cloning a repository that contains a bare repository
    -               and running a Git command within that directory.
    +           If you do not use bare repositories in your workflow, then it may
    +           be beneficial to set safe.bareRepository to explicit in your global
    +           config. This will protect you from attacks that involve cloning a
    +           repository that contains a bare repository and running a Git
    +           command within that directory.
    
    -               This config setting is only respected in protected
    -               configuration (see the section called “SCOPES”). This prevents
    -               untrusted repositories from tampering with this value.
    +           This config setting is only respected in protected configuration
    +           (see the section called “SCOPES”). This prevents untrusted
    +           repositories from tampering with this value.
    
            safe.directory
                These config entries specify Git-tracked directories that are

 Documentation/config.adoc          | 4 +++-
 Documentation/config/promisor.adoc | 2 ++
 Documentation/config/safe.adoc     | 2 ++
 Documentation/git-config.adoc      | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index dcea3c0c15..fc48c1c461 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -276,13 +276,15 @@ boolean::
        When a variable is said to take a boolean value, many
        synonyms are accepted for 'true' and 'false'; these are all
        case-insensitive.
-
++
+--
 	true;; Boolean true literals are `yes`, `on`, `true`,
 		and `1`.  Also, a variable defined without `= <value>`
 		is taken as true.
 
 	false;; Boolean false literals are `no`, `off`, `false`,
 		`0` and the empty string.
+--
 +
 When converting a value to its canonical form using the `--type=bool` type
 specifier, 'git config' will ensure that the output is "true" or
diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
index b0fa43b839..39af63dcb8 100644
--- a/Documentation/config/promisor.adoc
+++ b/Documentation/config/promisor.adoc
@@ -63,11 +63,13 @@ If one of these field names (e.g., "token") is being checked for an
 advertised promisor remote (e.g., "foo"), three conditions must be met
 for the check of this specific field to pass:
 +
+--
 1. The corresponding local configuration (e.g., `remote.foo.token`)
    must be set.
 2. The server must advertise the "token" field for remote "foo".
 3. The value of the locally configured `remote.foo.token` must exactly
    match the value advertised by the server for the "token" field.
+--
 +
 If any of these conditions is not met for any field name listed in
 `promisor.checkFields`, the advertised remote "foo" is rejected.
diff --git a/Documentation/config/safe.adoc b/Documentation/config/safe.adoc
index 2d45c98b12..5ae4476b24 100644
--- a/Documentation/config/safe.adoc
+++ b/Documentation/config/safe.adoc
@@ -2,10 +2,12 @@ safe.bareRepository::
 	Specifies which bare repositories Git will work with. The currently
 	supported values are:
 +
+--
 * `all`: Git works with all bare repositories. This is the default.
 * `explicit`: Git only works with bare repositories specified via
   the top-level `--git-dir` command-line option, or the `GIT_DIR`
   environment variable (see linkgit:git[1]).
+--
 +
 If you do not use bare repositories in your workflow, then it may be
 beneficial to set `safe.bareRepository` to `explicit` in your global
diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index 00545b2054..8439ce97df 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -221,6 +221,7 @@ Use `--no-value` to unset _<pattern>_.
 +
 Valid `<type>`'s include:
 +
+--
 - 'bool': canonicalize values `true`, `yes`, `on`, and positive
   numbers as "true", and values `false`, `no`, `off` and `0` as
   "false".
@@ -239,6 +240,7 @@ Valid `<type>`'s include:
   escape sequence. When setting a value, a sanity-check is performed to ensure
   that the given value is canonicalize-able as an ANSI color, but it is written
   as-is.
+--
 +
 If the command is in `list` mode, then the `--type <type>` argument will apply
 to each listed config value. If the value does not successfully parse in that
-- 
2.30.2

