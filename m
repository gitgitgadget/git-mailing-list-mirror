From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v1 3/3] travis-ci: run Git bisect on failed tests
Date: Sun, 22 May 2016 22:51:20 +0530
Message-ID: <CAFZEwPOuCRJFx0wH5YHKxWNmjkvi2R6s5G0Bw+WrnHywT3cR0g@mail.gmail.com>
References: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com>
	<1463914856-64745-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 22 19:21:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4X4B-0005ju-6n
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 19:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434AbcEVRVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 13:21:22 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35768 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbcEVRVV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 13:21:21 -0400
Received: by mail-yw0-f193.google.com with SMTP id n16so7490504ywd.2
        for <git@vger.kernel.org>; Sun, 22 May 2016 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=H7WL5sqVbe04ir79TSf+72nDTQIsswx2eyYyMFvjikw=;
        b=ZEBESnRBpP1X4T415M6X00cGlnmdNE8ryBNGgxKBX11VzAevyRLllcXk/oTnVyJ9zh
         kleI5nChqg1R3UZTJ6yq9CaQA1kEZIRh0ZuXPxiH/GM9IFMjMc+dOHiCm3Rzq3/UcFd2
         wYsgG6ZAP4seJ3l0oRTo4jfBjapm5OVpx2FpLqlNnGfpE+aRuZZNEUKnmbDmJFLcvWGK
         TGtg+k6+E/R3EW/4c4TRgH7LeLm0hZxjA429TY1FHSoA/tm0a7fhvpDPi+SIq/1ftn2s
         ohORt3a1SPUgHc9LCzX/RKew2ph8X0XeSfZrDgEN0kNXHPFU04rt/n6RiBTvRX2bHC4N
         gvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=H7WL5sqVbe04ir79TSf+72nDTQIsswx2eyYyMFvjikw=;
        b=Zv0gKz5Xr7xVRnuP+tVbGoNdxMOl67fSpetVUa/VVTXV5iF3mRL0b061MaLkNMihOu
         A916qZUT8z+JXdDve4+dgQzOPOcaeJ1lhJQ1Zv0WDBO9IhmWJjYkRBvRg+mP9OdGCpk5
         1Y436KejLPFYNmO+xYsDgdcNcX2+cn/2X9mx4QtmQcR+O2JHH+aShJpDgkbwlBRW7YD4
         VOR2uszSG+q4IaCmIE57KWF4/nwdE8F/yI4uYR+Rz3Ewr3DofeREeDNUtg2OzE8G+H6F
         VwDP2V9bKbpWwGxN4iBh2DF4pRo/bdW3wztJ9W+5piMuDCDoDhfcf3MutI05lGoQhBfw
         CAWg==
X-Gm-Message-State: AOPr4FUpSkIYyiBB1AKZ4yjDFD6+fWpd3lX0Hjp1d55UmI3Pnd98cqy2/86fup19VoAmBlnnRqRvcWkztqXSTA==
X-Received: by 10.13.198.5 with SMTP id i5mr8069457ywd.263.1463937680350; Sun,
 22 May 2016 10:21:20 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Sun, 22 May 2016 10:21:20 -0700 (PDT)
In-Reply-To: <1463914856-64745-4-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295287>

Hey Lars,

On Sun, May 22, 2016 at 4:30 PM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Junio usually pushes many commits at once to the public "pu"/"next"/
> "master" branches. If a test fails then it is not obvious what commit
> caused the failure. Therefore we run Git bisect with the merge base
> between the failing rev and its more stable branch ("next" for "pu",
> "master" for "next", and "maint" for "master") as good ref to find the
> offending commit. This is only enabled on "github.com/git/git" because
> there we can assume that all relevant branches are up to date.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  .travis.yml       |  2 +-
>  ci/test-report.sh | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 81d2027..922807b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -101,7 +101,7 @@ script: make --quiet test
>  after_failure:
>    - >
>      : '<-- Click here to see detailed test output!                                                        ';
> -    ./ci/test-report.sh
> +    ./ci/test-report.sh $TRAVIS_REPO_SLUG $TRAVIS_BRANCH;
>
>  notifications:
>    email: false
> diff --git a/ci/test-report.sh b/ci/test-report.sh
> index d08a999..8f7adad 100755
> --- a/ci/test-report.sh
> +++ b/ci/test-report.sh
> @@ -1,5 +1,12 @@
>  #!/bin/sh
>  #
> +# Print test results and run Git bisect on failed tests.
> +#
> +REPO_ORG_NAME=$1
> +CURRENT_BRANCH_NAME=$2
> +
> +
> +#
>  # Print test results
>  #
>  for TEST_EXIT in t/test-results/*.exit
> @@ -17,3 +24,61 @@ do
>         fi
>  done
>
> +
> +#
> +# Run Git bisect
> +#
> +run_bisect () {
> +       TEST_SCRIPT=$1
> +       BAD_REV=$2
> +       GOOD_RV=$3
> +       TMPDIR=$(mktemp -d -t "ci-report-bisect-XXXXXX" 2>/dev/null)
> +       cat > "$TMPDIR/bisect-run.sh" <<EOF

If you are doing a re-roll, then you could probably fix the style issue.
' cat >"$TMPDIR..."  '

> +
> +EOF
> +       chmod +x "$TMPDIR/bisect-run.sh"
> +       git bisect start $BAD_REV $GOOD_RV
> +       git bisect run "$TMPDIR/bisect-run.sh"
> +       if test -e ./t/$TEST_SCRIPT.sh && make --jobs=2 >/dev/null 2>&1
> +       then
> +               cd t && ./$TEST_SCRIPT.sh >/dev/null 2>&1
> +       else
> +               # If the test file does not exist or the build fails then tell
> +               # Git bisect to skip the commit.
> +               exit 125
> +       fi
> +       git bisect reset >/dev/null 2>&1
> +}
> +
> +case "$CURRENT_BRANCH_NAME" in
> +       master) STABLE_BRANCH="maint";;
> +       next)   STABLE_BRANCH="master";;
> +       pu)     STABLE_BRANCH="next";;
> +esac
> +
> +if test "$REPO_ORG_NAME" = "git/git" && test -n $STABLE_BRANCH
> +then
> +       BAD_REV=$(git rev-parse HEAD)
> +
> +       # Travis CI clones are shallow. It is possible that the last good revision
> +       # was not fetched, yet. Therefore we need to fetch all commits on the
> +       # stable branch.
> +       git config remote.origin.fetch "+refs/heads/$STABLE_BRANCH:refs/remotes/origin/$STABLE_BRANCH"
> +       git fetch --unshallow --quiet
> +       LAST_GOOD_REV=$(git merge-base $BAD_REV "remotes/origin/$STABLE_BRANCH")
> +
> +       for TEST_EXIT in t/test-results/*.exit
> +       do
> +               if test "$(cat "$TEST_EXIT")" != "0"
> +               then
> +                       TEST="${TEST_EXIT%.exit}"
> +                       TEST_SCRIPT=${TEST#t/test-results/}
> +                       echo "------------------------------------------------------------------------"
> +                       echo "  $(tput setaf 1)${TEST} Bisect$(tput sgr0)"
> +                       echo "------------------------------------------------------------------------"
> +                       run_bisect $TEST_SCRIPT $BAD_REV $LAST_GOOD_REV
> +                       echo ""
> +                       echo ""
> +               fi
> +       done
> +fi

Regards,
Pranit Bauva
